import Foundation

public enum PetPhase: String, Codable, Sendable {
    case egg
    case alive
    case dead
}

public enum Stage: Int, Codable, Sendable {
    case stage1 = 1
    case stage2 = 2
    case stage3 = 3
}

public struct MbtiScores: Codable, Sendable {
    public var extroversion: Int
    public var intuition: Int
    public var thinking: Int
    public var judging: Int

    public init(extroversion: Int = 0, intuition: Int = 0, thinking: Int = 0, judging: Int = 0) {
        self.extroversion = extroversion
        self.intuition = intuition
        self.thinking = thinking
        self.judging = judging
    }
}

public struct EquippedItems: Codable, Sendable {
    public var head: String?
    public var hand: String?
    public var effect: String?

    public init(head: String? = nil, hand: String? = nil, effect: String? = nil) {
        self.head = head
        self.hand = hand
        self.effect = effect
    }
}

public struct PetState: Codable, Sendable {
    public var machineId: String
    public var phase: PetPhase
    public var species: String?
    public var name: String?
    public var level: Int
    public var xp: Int
    public var totalXp: Int
    public var hp: Int
    public var hunger: Int
    public var mood: Int
    public var mbtiScores: MbtiScores
    public var personality: String?
    public var equippedItems: EquippedItems
    public var inventory: [Equipment]
    public var unlockedAchievements: [String]
    public var graveyardEntries: [GraveyardEntry]
    public var createdAt: Date
    public var lastActiveAt: Date
    public var totalPrompts: Int
    public var totalToolUses: Int
    public var totalSessions: Int
    public var consecutiveWorkdays: Int
    public var deathCount: Int
    public var streakDays: Int
    public var longestStreak: Int
    public var lastStreakDate: Date?
    public var lastWorkdayDate: Date?
    public var bugsCaught: Int
    public var goldenBugsCaught: Int
    public var rainbowBugsCaught: Int
    public var activeBugs: [ActiveBug]

    public var stage: Stage {
        if level >= 26 { return .stage3 }
        if level >= 11 { return .stage2 }
        return .stage1
    }

    public init(machineId: String) {
        self.machineId = machineId
        self.phase = .egg
        self.species = nil
        self.name = nil
        self.level = 0
        self.xp = 0
        self.totalXp = 0
        self.hp = 100
        self.hunger = 100
        self.mood = 100
        self.mbtiScores = MbtiScores()
        self.personality = nil
        self.equippedItems = EquippedItems()
        self.inventory = []
        self.unlockedAchievements = []
        self.graveyardEntries = []
        self.createdAt = Date()
        self.lastActiveAt = Date()
        self.totalPrompts = 0
        self.totalToolUses = 0
        self.totalSessions = 0
        self.consecutiveWorkdays = 0
        self.deathCount = 0
        self.streakDays = 0
        self.longestStreak = 0
        self.lastStreakDate = nil
        self.lastWorkdayDate = nil
        self.bugsCaught = 0
        self.goldenBugsCaught = 0
        self.rainbowBugsCaught = 0
        self.activeBugs = []
    }
}
