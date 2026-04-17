import Foundation

public struct GraveyardEntry: Codable, Sendable, Identifiable {
    public let id: String
    public let species: String?
    public let name: String?
    public let personality: String?
    public let level: Int
    public let totalXp: Int
    public let diedAt: Date
    public let bornAt: Date
    public let causeOfDeath: String

    public init(from state: PetState, cause: String = "14 영업일 연속 미사용") {
        self.id = UUID().uuidString
        self.species = state.species
        self.name = state.name
        self.personality = state.personality
        self.level = state.level
        self.totalXp = state.totalXp
        self.diedAt = Date()
        self.bornAt = state.createdAt
        self.causeOfDeath = cause
    }
}
