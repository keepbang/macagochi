import Foundation

public struct FeedProcessor: Sendable {
    private let xpEngine: XPEngine
    private let healthSystem: HealthSystem

    public init(xpEngine: XPEngine = XPEngine(), healthSystem: HealthSystem = HealthSystem()) {
        self.xpEngine = xpEngine
        self.healthSystem = healthSystem
    }

    public func process(event: BehaviorEvent, state: inout PetState) {
        let xp = xpEngine.xpForEvent(event)
        state.totalXp += xp
        state.xp += xp
        state.lastActiveAt = event.timestamp

        switch event.kind {
        case .prompt: state.totalPrompts += 1
        case .toolUse: state.totalToolUses += 1
        case .sessionStart: state.totalSessions += 1
        }

        if state.phase == .egg && xpEngine.shouldHatch(totalXp: state.totalXp) {
            state.phase = .alive
            state.level = 1
            state.xp = state.totalXp - 100
        }

        if state.phase == .alive {
            let result = xpEngine.checkLevelUp(currentLevel: state.level, currentXp: state.xp)
            state.level = result.newLevel
            state.xp = result.remainingXp
            healthSystem.applyRecovery(to: &state)
        }
    }
}
