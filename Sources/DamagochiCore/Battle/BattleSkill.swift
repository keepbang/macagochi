import Foundation

// MARK: - Skill Effect

public enum SkillEffect: Codable, Sendable {
    /// 일반 물리 공격 (ATK 기반)
    case physicalAttack(multiplier: Double)
    /// 마법 공격 (INT 기반)
    case magicAttack(multiplier: Double)
    /// SPD 기반 공격 + 선공 보장
    case spdAttack(multiplier: Double)
    /// 다음 받는 피해 반사 (비율)
    case reflectNext(ratio: Double)
    /// DEF 증폭 (이번 턴)
    case buffDef(ratio: Double)
    /// ATK 증폭 (다음 공격 1회)
    case buffAtk(ratio: Double)
    /// INT 증폭 (다음 공격 1회)
    case buffInt(ratio: Double)
    /// HP 회복 (maxHp 비율)
    case heal(ratio: Double)
    /// 회피 (다음 받는 공격)
    case dodge(chance: Double)
    /// 조건부 ATK 증폭 (HP < threshold 이면 highRatio, 아니면 lowRatio)
    case berserk(threshold: Double, highRatio: Double, lowRatio: Double)
}

// MARK: - Skill Definition

public struct BattleSkill: Sendable {
    public let id: String
    public let name: String
    public let icon: String
    public let effect: SkillEffect
    public let isAttack: Bool

    public init(id: String, name: String, icon: String, effect: SkillEffect, isAttack: Bool) {
        self.id = id
        self.name = name
        self.icon = icon
        self.effect = effect
        self.isAttack = isAttack
    }
}

// MARK: - Skills per MBTI Group

public extension BattleSkill {

    // MARK: NT (분석형) — 공격 2 + 유틸 2
    static let ntSkills: [BattleSkill] = [
        BattleSkill(
            id: "nt_overclock",
            name: "오버클락",
            icon: "⚡",
            effect: .physicalAttack(multiplier: 1.3),
            isAttack: true
        ),
        BattleSkill(
            id: "nt_analyze",
            name: "분석타",
            icon: "🔍",
            effect: .magicAttack(multiplier: 1.2),   // 피해 + 상대 DEF -20% 효과는 BattleEngine에서 처리
            isAttack: true
        ),
        BattleSkill(
            id: "nt_counter",
            name: "카운터",
            icon: "🛡️",
            effect: .reflectNext(ratio: 0.5),
            isAttack: false
        ),
        BattleSkill(
            id: "nt_barrier",
            name: "방어막",
            icon: "🔒",
            effect: .buffDef(ratio: 0.4),
            isAttack: false
        ),
    ]

    // MARK: NF (창의형) — 공격 2 + 유틸 2
    static let nfSkills: [BattleSkill] = [
        BattleSkill(
            id: "nf_starburst",
            name: "별빛 폭발",
            icon: "✨",
            effect: .magicAttack(multiplier: 1.4),
            isAttack: true
        ),
        BattleSkill(
            id: "nf_curse",
            name: "저주",
            icon: "💫",
            effect: .magicAttack(multiplier: 1.0),   // 피해 + 상대 ATK -25% 효과는 BattleEngine에서 처리
            isAttack: true
        ),
        BattleSkill(
            id: "nf_inspire",
            name: "영감",
            icon: "🌟",
            effect: .buffInt(ratio: 0.4),
            isAttack: false
        ),
        BattleSkill(
            id: "nf_mystic",
            name: "신비",
            icon: "🌀",
            effect: .dodge(chance: 0.45),
            isAttack: false
        ),
    ]

    // MARK: SJ (안정형) — 공격 2 + 유틸 2
    static let sjSkills: [BattleSkill] = [
        BattleSkill(
            id: "sj_smash",
            name: "강타",
            icon: "💪",
            effect: .physicalAttack(multiplier: 1.4),
            isAttack: true
        ),
        BattleSkill(
            id: "sj_thorn",
            name: "가시 반격",
            icon: "🌵",
            effect: .physicalAttack(multiplier: 1.0),  // 피해 + 이번 턴 받는 피해 30% 반사
            isAttack: true
        ),
        BattleSkill(
            id: "sj_ironwall",
            name: "철벽",
            icon: "🧱",
            effect: .buffDef(ratio: 0.6),
            isAttack: false
        ),
        BattleSkill(
            id: "sj_heal",
            name: "회복",
            icon: "💚",
            effect: .heal(ratio: 0.2),
            isAttack: false
        ),
    ]

    // MARK: SP (자유형) — 공격 2 + 유틸 2
    static let spSkills: [BattleSkill] = [
        BattleSkill(
            id: "sp_ambush",
            name: "기습",
            icon: "💨",
            effect: .spdAttack(multiplier: 2.0),   // SPD 기반 + 이번 턴 선공 보장
            isAttack: true
        ),
        BattleSkill(
            id: "sp_combo",
            name: "연속 공격",
            icon: "⚔️",
            effect: .physicalAttack(multiplier: 1.2),  // 2회 판정은 BattleEngine에서 처리
            isAttack: true
        ),
        BattleSkill(
            id: "sp_dodge",
            name: "회피",
            icon: "🌪️",
            effect: .dodge(chance: 0.5),
            isAttack: false
        ),
        BattleSkill(
            id: "sp_berserk",
            name: "광전사",
            icon: "🔥",
            effect: .berserk(threshold: 0.5, highRatio: 0.6, lowRatio: 0.2),
            isAttack: false
        ),
    ]

    static func skills(for group: MbtiGroup) -> [BattleSkill] {
        switch group {
        case .nt: return ntSkills
        case .nf: return nfSkills
        case .sj: return sjSkills
        case .sp: return spSkills
        }
    }
}
