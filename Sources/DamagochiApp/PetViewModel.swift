import Foundation
import Combine
import CryptoKit
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

@MainActor
final class PetViewModel: ObservableObject {
    @Published var state: PetState
    @Published var selectedTab: AppTab = .pet
    @Published var notification: PetNotification?
    @Published var hookInstalled: Bool = false
    @Published var notificationsEnabled: Bool {
        didSet { UserDefaults.standard.set(notificationsEnabled, forKey: "notificationsEnabled") }
    }

    private let store = PetStore()
    private let processor = FeedProcessor()
    private let deathChecker = DeathChecker()
    private let inventoryManager = InventoryManager()
    private let hookInstaller = HookInstaller()
    private let notificationManager = NotificationManager.shared
    private var eventObserver: NSObjectProtocol?
    private var monitor: ClaudeSessionMonitor?
    private var deathCheckTimer: AnyCancellable?
    private var notificationTimer: AnyCancellable?

    var currentFrames: [PixelSprite] {
        SpriteSheet.frames(
            species: state.species,
            stage: state.stage,
            phase: state.phase,
            equipped: state.equippedItems,
            inventory: state.inventory
        )
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
        guard needed > 0 else { return 1 }
        return min(1.0, Double(state.xp) / Double(needed))
    }

    var xpNeededForNextLevel: Int {
        XPEngine().xpNeededForLevel(state.level + 1)
    }

    init() {
        self.notificationsEnabled = UserDefaults.standard.object(forKey: "notificationsEnabled") as? Bool ?? true
        let hostHash = ProcessInfo.processInfo.hostName
            .data(using: .utf8)
            .map { CryptoKit.SHA256.hash(data: $0) }
            .map { $0.prefix(8).map { String(format: "%02x", $0) }.joined() }
            ?? "unknown"
        self.state = store.load() ?? PetState(machineId: hostHash)
        self.hookInstalled = hookInstaller.isInstalled()
    }

    func start() {
        if notificationsEnabled {
            notificationManager.requestPermission()
        }

        checkDeath()

        if state.phase == .alive {
            let engine = XPEngine()
            let result = engine.checkLevelUp(currentLevel: state.level, currentXp: state.xp)
            if result.newLevel != state.level {
                state.level = result.newLevel
                state.xp = result.remainingXp
                save()
            }
        }

        let pending = EventBridge.drainFileEvents()
        for event in pending {
            processor.process(event: event, state: &state)
        }
        if !pending.isEmpty { save() }

        eventObserver = EventBridge.observe { [weak self] event in
            Task { @MainActor in self?.handleEvent(event) }
        }

        monitor = ClaudeSessionMonitor(
            onDelta: { [weak self] delta in
                Task { @MainActor in self?.handleDelta(delta) }
            },
            onSessionStart: { [weak self] in
                let event = BehaviorEvent(kind: .sessionStart)
                Task { @MainActor in self?.handleEvent(event) }
            }
        )
        monitor?.startMonitoring()

        deathCheckTimer = Timer.publish(every: 3600, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in self?.checkDeath() }
    }

    func stop() {
        if let observer = eventObserver {
            EventBridge.removeObserver(observer)
        }
        monitor?.stopMonitoring()
        deathCheckTimer?.cancel()
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
        let result = processor.process(event: event, state: &state)
        checkNotifications(oldLevel: oldLevel, oldPhase: oldPhase, result: result)
        save()
    }

    private func handleDelta(_ delta: SessionDelta) {
        let oldLevel = state.level
        let oldPhase = state.phase
        var combinedResult = FeedResult()
        for _ in 0..<delta.newPrompts {
            let r = processor.process(event: BehaviorEvent(kind: .prompt), state: &state)
            combinedResult = combinedResult.merged(with: r)
        }
        for _ in 0..<delta.newToolUses {
            let r = processor.process(event: BehaviorEvent(kind: .toolUse), state: &state)
            combinedResult = combinedResult.merged(with: r)
        }
        checkNotifications(oldLevel: oldLevel, oldPhase: oldPhase, result: combinedResult)
        save()
    }

    private func checkNotifications(oldLevel: Int, oldPhase: PetPhase, result: FeedResult) {
        if oldPhase == .egg && state.phase == .alive {
            showNotification("🐣 알이 부화했습니다!", icon: "sparkles")
            let speciesName = state.species.flatMap { id in
                Species.allSpecies.first(where: { $0.id == id })?.name
            } ?? "펫"
            sendSystemNotification { $0.sendHatched(speciesName: speciesName) }
        } else if state.level > oldLevel {
            showNotification("⬆️ 레벨 \(state.level) 달성!", icon: "arrow.up.circle.fill")
            sendSystemNotification { $0.sendLevelUp(level: self.state.level) }
        }

        for item in result.droppedEquipment {
            sendSystemNotification { $0.sendEquipmentDrop(name: item.name) }
        }
        for achievement in result.newAchievements {
            sendSystemNotification { $0.sendAchievement(name: achievement.name) }
        }

        if state.phase == .alive && state.hunger < 20 {
            sendSystemNotification { $0.sendHungerWarning(hunger: self.state.hunger) }
        }
    }

    private func checkDeath() {
        guard state.phase == .alive else { return }
        let days = deathChecker.inactiveBusinessDays(lastActive: state.lastActiveAt, now: Date())

        if deathChecker.shouldDie(inactiveBusinessDays: days) {
            let entry = deathChecker.processDeath(state: &state)
            state.graveyardEntries.append(entry)
            save()
            showNotification("💀 펫이 사망했습니다...", icon: "heart.slash.fill")
            sendSystemNotification { $0.sendDeath() }
            return
        }

        let warning = deathChecker.warningLevel(inactiveBusinessDays: days)
        switch warning {
        case .critical:
            sendSystemNotification { $0.sendDeathRisk(days: days) }
        case .warning:
            sendSystemNotification { $0.sendDeathRisk(days: days) }
        case .none:
            break
        }
    }

    private func sendSystemNotification(_ action: (NotificationManager) -> Void) {
        guard notificationsEnabled else { return }
        action(notificationManager)
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
