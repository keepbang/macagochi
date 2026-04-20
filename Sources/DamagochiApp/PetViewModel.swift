import Foundation
import DamagochiCore
import DamagochiMonitor
import DamagochiStorage

final class PetViewModel: ObservableObject {
    @Published var state: PetState

    private let store = PetStore()
    private let processor = FeedProcessor()
    private var eventObserver: NSObjectProtocol?
    private var monitor: ClaudeSessionMonitor?

    init() {
        self.state = store.load() ?? PetState(machineId: ProcessInfo.processInfo.hostName)
    }

    func start() {
        let pending = EventBridge.drainFileEvents()
        for event in pending {
            processor.process(event: event, state: &state)
        }
        if !pending.isEmpty { save() }

        eventObserver = EventBridge.observe { [weak self] event in
            DispatchQueue.main.async {
                self?.handleEvent(event)
            }
        }

        monitor = ClaudeSessionMonitor(
            onDelta: { [weak self] delta in
                DispatchQueue.main.async {
                    self?.handleDelta(delta)
                }
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

    private func handleEvent(_ event: BehaviorEvent) {
        processor.process(event: event, state: &state)
        save()
    }

    private func handleDelta(_ delta: SessionDelta) {
        for _ in 0..<delta.newPrompts {
            processor.process(event: BehaviorEvent(kind: .prompt), state: &state)
        }
        for _ in 0..<delta.newToolUses {
            processor.process(event: BehaviorEvent(kind: .toolUse), state: &state)
        }
        save()
    }

    private func save() {
        store.save(state)
    }
}
