import Foundation

public struct XPEngine: Sendable {
    public init() {}

    public func xpForEvent(_ event: BehaviorEvent) -> Int {
        switch event.kind {
        case .prompt: return 5
        case .toolUse: return 3
        case .sessionStart: return 10
        }
    }

    public func streakMultiplier(streakDays: Int) -> Double {
        switch streakDays {
        case 0...2:   return 1.0
        case 3...6:   return 1.5
        case 7...13:  return 2.0
        case 14...29: return 3.0
        default:      return 5.0
        }
    }

    public func xpForEvent(_ event: BehaviorEvent, streakDays: Int) -> Int {
        let base = xpForEvent(event)
        let multiplier = streakMultiplier(streakDays: streakDays)
        return Int(Double(base) * multiplier)
    }

    public func xpNeededForLevel(_ level: Int) -> Int {
        level * 50
    }

    public func shouldHatch(totalXp: Int) -> Bool {
        totalXp >= 100
    }

    public func checkLevelUp(currentLevel: Int, currentXp: Int) -> (newLevel: Int, remainingXp: Int) {
        var level = currentLevel
        var xp = currentXp
        var needed = xpNeededForLevel(level + 1)
        while xp >= needed {
            xp -= needed
            level += 1
            needed = xpNeededForLevel(level + 1)
        }
        return (level, xp)
    }

    public func stageForLevel(_ level: Int) -> Stage {
        if level >= 26 { return .stage3 }
        if level >= 11 { return .stage2 }
        return .stage1
    }
}
