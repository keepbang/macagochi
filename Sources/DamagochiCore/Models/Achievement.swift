import Foundation

public enum AchievementTier: String, Codable, Sendable {
    case bronze
    case silver
    case gold
    case diamond
}

public struct Achievement: Codable, Sendable, Identifiable {
    public let id: String
    public let name: String
    public let description: String
    public let tier: AchievementTier
    public var unlockedAt: Date?

    public var isUnlocked: Bool { unlockedAt != nil }

    public init(id: String, name: String, description: String, tier: AchievementTier, unlockedAt: Date? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.tier = tier
        self.unlockedAt = unlockedAt
    }
}
