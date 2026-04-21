import Foundation

public enum BugType: String, Codable, Sendable, CaseIterable {
    case normal
    case rare
    case golden
    case rainbow

    public var xpReward: Int {
        switch self {
        case .normal:  return 15
        case .rare:    return 40
        case .golden:  return 100
        case .rainbow: return 300
        }
    }

    public var timeout: TimeInterval {
        return self == .rainbow ? 15 : 30
    }

    public var emoji: String {
        switch self {
        case .normal:  return "🐛"
        case .rare:    return "💙"
        case .golden:  return "⭐"
        case .rainbow: return "🌈"
        }
    }

    public static func roll() -> BugType {
        let roll = Int.random(in: 1...100)
        if roll == 1 { return .rainbow }
        if roll <= 10 { return .golden }
        if roll <= 30 { return .rare }
        return .normal
    }
}

public struct ActiveBug: Codable, Sendable, Identifiable {
    public let id: String
    public let type: BugType
    public let spawnedAt: Date

    public init(type: BugType) {
        self.id = UUID().uuidString
        self.type = type
        self.spawnedAt = Date()
    }

    public var isExpired: Bool {
        Date().timeIntervalSince(spawnedAt) > type.timeout
    }
}
