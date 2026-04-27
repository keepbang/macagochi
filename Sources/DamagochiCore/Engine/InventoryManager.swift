import Foundation

public struct InventoryManager: Sendable {
    public init() {}

    @discardableResult
    public func addToInventory(item: Equipment, state: inout PetState) -> Bool {
        guard !state.inventory.contains(where: { $0.id == item.id }) else { return false }
        state.inventory.append(item)
        return true
    }

    public func equip(itemId: String, state: inout PetState) -> Bool {
        guard let item = state.inventory.first(where: { $0.id == itemId }) else {
            return false
        }

        switch item.slot {
        case .head: state.equippedItems.head = itemId
        case .hand: state.equippedItems.hand = itemId
        case .effect: state.equippedItems.effect = itemId
        }
        return true
    }

    public func unequip(slot: EquipmentSlot, state: inout PetState) {
        switch slot {
        case .head: state.equippedItems.head = nil
        case .hand: state.equippedItems.hand = nil
        case .effect: state.equippedItems.effect = nil
        }
    }

    public func equippedItem(for slot: EquipmentSlot, in state: PetState) -> Equipment? {
        let itemId: String?
        switch slot {
        case .head: itemId = state.equippedItems.head
        case .hand: itemId = state.equippedItems.hand
        case .effect: itemId = state.equippedItems.effect
        }
        guard let id = itemId else { return nil }
        return state.inventory.first(where: { $0.id == id })
    }
}
