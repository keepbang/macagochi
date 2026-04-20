import Foundation
import Combine
import DamagochiCore
import DamagochiMonitor
import DamagochiStorage
import DamagochiRenderer

enum AppTab: String, CaseIterable {
    case pet, inventory, achievements, graveyard, settings

    var icon: String {
        switch self {
        case .pet:          return "pawprint.fill"
        case .inventory:    return "bag.fill"
        case .achievements: return "trophy.fill"
        case .graveyard:    return "book.closed.fill"
        case .settings:     return "gearshape.fill"
        }
    }
}

struct PetNotification: Identifiable {
    let id = UUID()
    let message: String
    let icon: String
}

final class PetViewModel: ObservableObject {
    @Published var state: PetState
    @Published var selectedTab: AppTab = .pet
    @Published var notification: PetNotification?
    @Published var hookInstalled: Bool = false

    private let store = PetStore()
    private let processor = FeedProcessor()
    private let inventoryManager = InventoryManager()
    private let hookInstaller = HookInstaller()
    private var eventObserver: NSObjectProtocol?
    private var monitor: ClaudeSessionMonitor?
    private var notificationTimer: AnyCancellable?

    var currentFrames: [PixelSprite] {
        SpriteSheet.frames(species: state.species, stage: state.stage, phase: state.phase)
    }

    var statusMessage: String {
        switch state.phase {
        case .egg:
            return state.totalXp > 50 ? "곧 부화할 것 같아요..." : "따뜻하게 해주세요..."
        case .dead:
            return "..."
        case .alive:
            if state.hunger < 20 { return "배고파요..." }
            if state.hp < 30 { return "힘이 없어요..." }
            if state.mood < 30 { return "외로워요..." }
            if state.mood > 80 { return "기분이 좋아요!" }
            return "코딩 중..."
        }
    }

    var xpProgress: Double {
        let needed = XPEngine().xpNeededForLevel(state.level + 1)
        guard needed > 0 else { return 0 }
        return Double(state.xp) / Double(needed)
    }

    var xpNeededForNextLevel: Int {
        XPEngine().xpNeededForLevel(state.level + 1)
    }

    init() {
        self.state = store.load() ?? PetState(machineId: ProcessInfo.processInfo.hostName)
        self.hookInstalled = hookInstaller.isInstalled()
    }

    func start() {
        let pending = EventBridge.drainFileEvents()
        for event in pending {
            processor.process(event: event, state: &state)
        }
        if !pending.isEmpty { save() }

        eventObserver = EventBridge.observe { [weak self] event in
            DispatchQueue.main.async { self?.handleEvent(event) }
        }

        monitor = ClaudeSessionMonitor(
            onDelta: { [weak self] delta in
                DispatchQueue.main.async { self?.handleDelta(delta) }
            },
            onSessionStart: { [weak self] in
                DispatchQueue.main.async {
                    self?.handleEvent(BehaviorEvent(kind: .sessionStart))
                }
            }
        )
        monitor?.startMonitoring()
    }

    func stop() {
        if let observer = eventObserver {
            EventBridge.removeObserver(observer)
        }
        monitor?.stopMonitoring()
        save()
    }

    // MARK: - Equipment

    func equip(itemId: String) {
        if inventoryManager.equip(itemId: itemId, state: &state) {
            save()
        }
    }

    func unequip(slot: EquipmentSlot) {
        inventoryManager.unequip(slot: slot, state: &state)
        save()
    }

    func equippedItem(for slot: EquipmentSlot) -> Equipment? {
        inventoryManager.equippedItem(for: slot, in: state)
    }

    // MARK: - Hook Management

    func installHooks() {
        do {
            try hookInstaller.install()
            hookInstalled = true
        } catch {}
    }

    func uninstallHooks() {
        do {
            try hookInstaller.uninstall()
            hookInstalled = false
        } catch {}
    }

    // MARK: - Rebirth

    func rebirth() {
        guard state.phase == .dead else { return }
        let entry = GraveyardEntry(from: state)
        let previousEntries = state.graveyardEntries
        let previousDeathCount = state.deathCount
        let previousAchievements = state.unlockedAchievements
        state = PetState(machineId: state.machineId)
        state.graveyardEntries = previousEntries + [entry]
        state.deathCount = previousDeathCount + 1
        state.unlockedAchievements = previousAchievements
        save()
        showNotification("🔄 새로운 알이 나타났습니다!", icon: "arrow.counterclockwise.circle.fill")
    }

    // MARK: - Private

    private func handleEvent(_ event: BehaviorEvent) {
        let oldLevel = state.level
        let oldPhase = state.phase
        processor.process(event: event, state: &state)
        checkNotifications(oldLevel: oldLevel, oldPhase: oldPhase)
        save()
    }

    private func handleDelta(_ delta: SessionDelta) {
        let oldLevel = state.level
        let oldPhase = state.phase
        for _ in 0..<delta.newPrompts {
            processor.process(event: BehaviorEvent(kind: .prompt), state: &state)
        }
        for _ in 0..<delta.newToolUses {
            processor.process(event: BehaviorEvent(kind: .toolUse), state: &state)
        }
        checkNotifications(oldLevel: oldLevel, oldPhase: oldPhase)
        save()
    }

    private func checkNotifications(oldLevel: Int, oldPhase: PetPhase) {
        if oldPhase == .egg && state.phase == .alive {
            showNotification("🐣 알이 부화했습니다!", icon: "sparkles")
        } else if state.level > oldLevel {
            showNotification("⬆️ 레벨 \(state.level) 달성!", icon: "arrow.up.circle.fill")
        }
    }

    private func showNotification(_ message: String, icon: String) {
        notification = PetNotification(message: message, icon: icon)
        notificationTimer?.cancel()
        notificationTimer = Just(())
            .delay(for: .seconds(3), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in self?.notification = nil }
    }

    private func save() {
        store.save(state)
    }
}
