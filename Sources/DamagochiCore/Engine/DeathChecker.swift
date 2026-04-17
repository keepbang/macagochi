import Foundation

public enum DeathWarning: Sendable {
    case none
    case warning
    case critical
}

public struct DeathChecker: Sendable {
    public static let maxInactiveDays = 14

    public init() {}

    public func inactiveBusinessDays(lastActive: Date, now: Date) -> Int {
        let calendar = Calendar.current
        var count = 0
        var date = calendar.startOfDay(for: lastActive)
        let end = calendar.startOfDay(for: now)
        while date < end {
            date = calendar.date(byAdding: .day, value: 1, to: date)!
            let weekday = calendar.component(.weekday, from: date)
            if weekday != 1 && weekday != 7 {
                count += 1
            }
        }
        return count
    }

    public func warningLevel(inactiveBusinessDays: Int) -> DeathWarning {
        if inactiveBusinessDays >= 10 { return .critical }
        if inactiveBusinessDays >= 5 { return .warning }
        return .none
    }

    public func shouldDie(inactiveBusinessDays: Int) -> Bool {
        inactiveBusinessDays >= Self.maxInactiveDays
    }

    public func processDeath(state: inout PetState) -> GraveyardEntry {
        let entry = GraveyardEntry(from: state)
        state.phase = .dead
        state.hp = 0
        state.hunger = 0
        state.mood = 0
        return entry
    }

    public func restart(state: inout PetState) {
        let deathCount = state.deathCount + 1
        let machineId = state.machineId
        state = PetState(machineId: machineId)
        state.deathCount = deathCount
    }
}
