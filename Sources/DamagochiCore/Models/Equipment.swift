import Foundation

public enum Rarity: String, Codable, Sendable {
    case common
    case rare
    case legendary
    case mythic
}

public struct Equipment: Codable, Sendable, Identifiable {
    public let id: String
    public let name: String
    public let slot: EquipmentSlot
    public let rarity: Rarity
    public let description: String

    public init(id: String, name: String, slot: EquipmentSlot, rarity: Rarity, description: String) {
        self.id = id
        self.name = name
        self.slot = slot
        self.rarity = rarity
        self.description = description
    }
}

public enum EquipmentSlot: String, Codable, Sendable, CaseIterable {
    case head
    case hand
    case effect
}
