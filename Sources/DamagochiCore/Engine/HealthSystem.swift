import Foundation

public struct HealthSystem: Sendable {
    public init() {}

    public func applyDecay(to state: inout PetState, inactiveDays: Int) {
        guard state.phase == .alive else { return }
        state.hp = max(0, state.hp - 10 * inactiveDays)
        state.hunger = max(0, state.hunger - 15 * inactiveDays)
        state.mood = max(0, state.mood - 5 * inactiveDays)
    }

    public func applyRecovery(to state: inout PetState) {
        guard state.phase == .alive else { return }
        state.hp = min(100, state.hp + 5)
        state.hunger = min(100, state.hunger + 10)
        state.mood = min(100, state.mood + 3)
    }
}
