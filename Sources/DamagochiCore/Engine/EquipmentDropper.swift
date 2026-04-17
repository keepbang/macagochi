import Foundation

public struct EquipmentDropper: Sendable {
    public init() {}

    public func rollRarity() -> Rarity {
        let roll = Int.random(in: 1...100)
        if roll <= 5 { return .mythic }
        if roll <= 15 { return .legendary }
        if roll <= 40 { return .rare }
        return .common
    }

    public func dropEquipment(forLevel level: Int) -> Equipment {
        let rarity = rollRarity()
        let slot = EquipmentSlot.allCases.randomElement()!
        let item = randomItem(slot: slot, rarity: rarity, level: level)
        return item
    }

    private func randomItem(slot: EquipmentSlot, rarity: Rarity, level: Int) -> Equipment {
        let pool = Self.itemPool.filter { $0.slot == slot && $0.rarity == rarity }
        if let picked = pool.randomElement() {
            return picked
        }
        return Equipment(
            id: UUID().uuidString,
            name: "\(rarity.rawValue) \(slot.rawValue) Lv.\(level)",
            slot: slot,
            rarity: rarity,
            description: "레벨 \(level)에서 획득한 장비"
        )
    }

    static let itemPool: [Equipment] = [
        Equipment(id: "crown_common", name: "코딩 모자", slot: .head, rarity: .common, description: "평범한 코딩 모자"),
        Equipment(id: "crown_rare", name: "빛나는 왕관", slot: .head, rarity: .rare, description: "은은하게 빛나는 왕관"),
        Equipment(id: "crown_legendary", name: "용의 뿔", slot: .head, rarity: .legendary, description: "고대 용의 뿔로 만든 관"),
        Equipment(id: "crown_mythic", name: "천상의 후광", slot: .head, rarity: .mythic, description: "전설적인 천상의 후광"),
        Equipment(id: "hand_common", name: "나무 지팡이", slot: .hand, rarity: .common, description: "평범한 나무 지팡이"),
        Equipment(id: "hand_rare", name: "마법 키보드", slot: .hand, rarity: .rare, description: "빛나는 마법 키보드"),
        Equipment(id: "hand_legendary", name: "번개 마우스", slot: .hand, rarity: .legendary, description: "번개를 내뿜는 마우스"),
        Equipment(id: "hand_mythic", name: "무한의 터미널", slot: .hand, rarity: .mythic, description: "모든 것을 해결하는 터미널"),
        Equipment(id: "effect_common", name: "작은 반짝임", slot: .effect, rarity: .common, description: "소박한 반짝임 효과"),
        Equipment(id: "effect_rare", name: "코드 오라", slot: .effect, rarity: .rare, description: "코드가 흐르는 오라"),
        Equipment(id: "effect_legendary", name: "무지개 궤적", slot: .effect, rarity: .legendary, description: "무지개빛 궤적 효과"),
        Equipment(id: "effect_mythic", name: "우주 먼지", slot: .effect, rarity: .mythic, description: "우주의 먼지가 떠다니는 효과"),
    ]
}
