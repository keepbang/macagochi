import Foundation

// MARK: - Battle State

public struct BattleState: Sendable {
    public var myProfile: BattleProfile
    public var opponentProfile: BattleProfile
    public var turn: Int
    public var log: [String]
    public var status: BattleStatus

    // 버프/디버프 (해당 턴에만 적용 후 소멸)
    public var myBuffs: ActiveBuffs
    public var opponentBuffs: ActiveBuffs

    public init(me: BattleProfile, opponent: BattleProfile) {
        self.myProfile = me
        self.opponentProfile = opponent
        self.turn = 1
        self.log = []
        self.status = .ongoing
        self.myBuffs = ActiveBuffs()
        self.opponentBuffs = ActiveBuffs()
    }
}

public enum BattleStatus: Sendable, Equatable {
    case ongoing
    case victory
    case defeat
    case draw
}

public struct ActiveBuffs: Sendable {
    public var defMultiplier: Double = 1.0      // 방어막/철벽
    public var atkMultiplier: Double = 1.0      // 광전사/버프
    public var intMultiplier: Double = 1.0      // 영감
    public var reflectRatio: Double = 0.0       // 카운터/가시 반격
    public var dodgeChance: Double = 0.0        // 회피/신비
    public var debuffDefRatio: Double = 0.0     // 상대 DEF 감소
    public var debuffAtkRatio: Double = 0.0     // 상대 ATK 감소
    public var guaranteedFirst: Bool = false    // 기습 선공 보장
    public var atkBuffRemaining: Int = 0        // 남은 ATK 버프 턴 수
    public var intBuffRemaining: Int = 0        // 남은 INT 버프 턴 수

    public init() {}

    mutating func reset() {
        defMultiplier = 1.0
        if atkBuffRemaining <= 0 {
            atkMultiplier = 1.0
        }
        if intBuffRemaining <= 0 {
            intMultiplier = 1.0
        }
        reflectRatio = 0.0
        dodgeChance = 0.0
        debuffDefRatio = 0.0
        debuffAtkRatio = 0.0
        guaranteedFirst = false
    }
}

// MARK: - Battle Result

public struct BattleReward: Sendable {
    public let xpGained: Int
    public let droppedEquipment: Equipment?

    public init(xpGained: Int, droppedEquipment: Equipment?) {
        self.xpGained = xpGained
        self.droppedEquipment = droppedEquipment
    }
}

public struct BattleResult: Codable, Sendable {
    public let winnerId: String
    public let loserId: String
    public let turns: Int
    public let log: [String]

    public init(winnerId: String, loserId: String, turns: Int, log: [String]) {
        self.winnerId = winnerId
        self.loserId = loserId
        self.turns = turns
        self.log = log
    }
}

// MARK: - Battle Engine

public struct BattleEngine: Sendable {

    /// 한 턴 처리: 양쪽 스킬 선택 → SPD 순서로 실행 → 상태 반환
    public static func resolveTurn(
        state: inout BattleState,
        mySkillId: String,
        opponentSkillId: String
    ) {
        guard state.status == .ongoing else { return }

        let mySkills = BattleSkill.skills(for: state.myProfile.mbtiGroup)
        let opponentSkills = BattleSkill.skills(for: state.opponentProfile.mbtiGroup)

        guard let mySkill = mySkills.first(where: { $0.id == mySkillId }),
              let opponentSkill = opponentSkills.first(where: { $0.id == opponentSkillId })
        else { return }

        // spdAttack 스킬 사용 시 선공 보장 (determineFirst 호출 전에 설정)
        if case .spdAttack = mySkill.effect {
            state.myBuffs.guaranteedFirst = true
        }
        if case .spdAttack = opponentSkill.effect {
            state.opponentBuffs.guaranteedFirst = true
        }

        // 선공 결정: 기습 보장 > SPD 비교 > 랜덤
        let myGoesFirst = determineFirst(
            mySpd: state.myProfile.stats.spd,
            opponentSpd: state.opponentProfile.stats.spd,
            myGuaranteed: state.myBuffs.guaranteedFirst,
            opponentGuaranteed: state.opponentBuffs.guaranteedFirst
        )

        state.log.append("=== 턴 \(state.turn) ===")

        if myGoesFirst {
            applySkill(skill: mySkill, attacker: &state.myProfile, defender: &state.opponentProfile,
                       attackerBuffs: &state.myBuffs, defenderBuffs: &state.opponentBuffs,
                       attackerName: state.myProfile.petName, defenderName: state.opponentProfile.petName,
                       log: &state.log)
            if state.opponentProfile.stats.currentHp <= 0 {
                state.status = .victory
                state.turn += 1
                return
            }
            applySkill(skill: opponentSkill, attacker: &state.opponentProfile, defender: &state.myProfile,
                       attackerBuffs: &state.opponentBuffs, defenderBuffs: &state.myBuffs,
                       attackerName: state.opponentProfile.petName, defenderName: state.myProfile.petName,
                       log: &state.log)
            if state.myProfile.stats.currentHp <= 0 { state.status = .defeat }
        } else {
            applySkill(skill: opponentSkill, attacker: &state.opponentProfile, defender: &state.myProfile,
                       attackerBuffs: &state.opponentBuffs, defenderBuffs: &state.myBuffs,
                       attackerName: state.opponentProfile.petName, defenderName: state.myProfile.petName,
                       log: &state.log)
            if state.myProfile.stats.currentHp <= 0 {
                state.status = .defeat
                state.turn += 1
                return
            }
            applySkill(skill: mySkill, attacker: &state.myProfile, defender: &state.opponentProfile,
                       attackerBuffs: &state.myBuffs, defenderBuffs: &state.opponentBuffs,
                       attackerName: state.myProfile.petName, defenderName: state.opponentProfile.petName,
                       log: &state.log)
            if state.opponentProfile.stats.currentHp <= 0 { state.status = .victory }
        }

        // 턴 종료: 버프 소멸
        state.myBuffs.reset()
        state.opponentBuffs.reset()
        state.turn += 1
    }

    // MARK: - 스킬 적용

    private static func applySkill(
        skill: BattleSkill,
        attacker: inout BattleProfile,
        defender: inout BattleProfile,
        attackerBuffs: inout ActiveBuffs,
        defenderBuffs: inout ActiveBuffs,
        attackerName: String,
        defenderName: String,
        log: inout [String]
    ) {
        switch skill.effect {

        case .physicalAttack(let mult):
            let isCombo = skill.id == "sp_combo"
            let isThorn = skill.id == "sj_thorn"
            var atkStat = Double(attacker.stats.atk) * attackerBuffs.atkMultiplier
            atkStat *= (1.0 - defenderBuffs.debuffAtkRatio)
            let effectiveDef = Double(defender.stats.def) * defenderBuffs.defMultiplier * (1.0 - defenderBuffs.debuffDefRatio)

            if isThorn {
                // 가시 반격: 공격 + 이번 턴 받는 피해 30% 반사 등록
                let dmg = calcDamage(attack: atkStat * mult, def: effectiveDef, dodgeChance: defenderBuffs.dodgeChance)
                applyDamage(dmg, to: &defender, reflectTo: &attacker, reflectRatio: defenderBuffs.reflectRatio, log: &log, attackerName: attackerName, defenderName: defenderName, skillName: skill.name)
                attackerBuffs.reflectRatio = 0.3
                log.append("  \(attackerName)에게 가시 반격 발동! 다음 피해의 30% 반사")
            } else if isCombo {
                // 연속 공격: 2회 판정
                for i in 1...2 {
                    let dmg = calcDamage(attack: atkStat * mult, def: effectiveDef, dodgeChance: defenderBuffs.dodgeChance)
                    applyDamage(dmg, to: &defender, reflectTo: &attacker, reflectRatio: defenderBuffs.reflectRatio, log: &log, attackerName: attackerName, defenderName: defenderName, skillName: "\(skill.name) \(i)타")
                    if defender.stats.currentHp <= 0 { break }
                }
            } else {
                let dmg = calcDamage(attack: atkStat * mult, def: effectiveDef, dodgeChance: defenderBuffs.dodgeChance)
                applyDamage(dmg, to: &defender, reflectTo: &attacker, reflectRatio: defenderBuffs.reflectRatio, log: &log, attackerName: attackerName, defenderName: defenderName, skillName: skill.name)
            }

        case .magicAttack(let mult):
            var intStat = Double(attacker.stats.int_) * attackerBuffs.intMultiplier
            // 저주는 물리/마법 공격력 모두 감소 (공격력 전체 디버프)
            intStat *= (1.0 - defenderBuffs.debuffAtkRatio)
            let effectiveDef = Double(defender.stats.def) * defenderBuffs.defMultiplier * (1.0 - defenderBuffs.debuffDefRatio)
            let dmg = calcDamage(attack: intStat * mult, def: effectiveDef, dodgeChance: defenderBuffs.dodgeChance)
            applyDamage(dmg, to: &defender, reflectTo: &attacker, reflectRatio: defenderBuffs.reflectRatio, log: &log, attackerName: attackerName, defenderName: defenderName, skillName: skill.name)

            // 분석타: 상대 DEF -20% 다음 턴
            if skill.id == "nt_analyze" {
                defenderBuffs.debuffDefRatio = 0.2
                log.append("  \(defenderName)의 방어력 -20% (다음 턴)")
            }

            // 저주: 상대 ATK -25% 다음 턴
            if skill.id == "nf_curse" {
                defenderBuffs.debuffAtkRatio = 0.25
                log.append("  \(defenderName)의 공격력 -25% (다음 턴)")
            }

        case .spdAttack(let mult):
            // SPD 기반 공격, 선공은 이미 결정된 상태
            let effectiveDef = Double(defender.stats.def) * defenderBuffs.defMultiplier * (1.0 - defenderBuffs.debuffDefRatio)
            let dmg = calcDamage(attack: Double(attacker.stats.spd) * mult, def: effectiveDef, dodgeChance: defenderBuffs.dodgeChance)
            applyDamage(dmg, to: &defender, reflectTo: &attacker, reflectRatio: defenderBuffs.reflectRatio, log: &log, attackerName: attackerName, defenderName: defenderName, skillName: skill.name)

        case .reflectNext(let ratio):
            attackerBuffs.reflectRatio = ratio
            log.append("  \(attackerName) \(skill.icon)\(skill.name) 발동 — 다음 피해의 \(Int(ratio*100))% 반사")

        case .buffDef(let ratio):
            attackerBuffs.defMultiplier = 1.0 + ratio
            log.append("  \(attackerName) \(skill.icon)\(skill.name) — 방어력 +\(Int(ratio*100))% (이번 턴)")

        case .buffAtk(let ratio):
            attackerBuffs.atkMultiplier = 1.0 + ratio
            attackerBuffs.atkBuffRemaining = 2
            log.append("  \(attackerName) \(skill.icon)\(skill.name) — 공격력 +\(Int(ratio*100))% (다음 공격)")

        case .buffInt(let ratio):
            attackerBuffs.intMultiplier = 1.0 + ratio
            attackerBuffs.intBuffRemaining = 2
            log.append("  \(attackerName) \(skill.icon)\(skill.name) — 마법 공격 +\(Int(ratio*100))% (다음 공격)")

        case .heal(let ratio):
            let healAmt = Int(Double(attacker.stats.maxHp) * ratio)
            let newHp = min(attacker.stats.maxHp, attacker.stats.currentHp + healAmt)
            attacker.stats.currentHp = newHp
            log.append("  \(attackerName) \(skill.icon)\(skill.name) — HP +\(healAmt) (\(newHp)/\(attacker.stats.maxHp))")

        case .dodge(let chance):
            attackerBuffs.dodgeChance = chance
            log.append("  \(attackerName) \(skill.icon)\(skill.name) — 다음 공격 \(Int(chance*100))% 회피 준비")

        case .berserk(let threshold, let highRatio, let lowRatio):
            let hpRatio = Double(attacker.stats.currentHp) / Double(attacker.stats.maxHp)
            let ratio = hpRatio < threshold ? highRatio : lowRatio
            attackerBuffs.atkMultiplier = 1.0 + ratio
            attackerBuffs.atkBuffRemaining = 2
            let label = hpRatio < threshold ? "광전사 발동!" : "준비 상태"
            log.append("  \(attackerName) \(skill.icon)\(skill.name) \(label) — 공격력 +\(Int(ratio*100))%")
        }

        // 공격 스킬 사용 후 버프 카운터 감소
        if skill.isAttack {
            if attackerBuffs.atkBuffRemaining > 0 {
                attackerBuffs.atkBuffRemaining -= 1
                if attackerBuffs.atkBuffRemaining <= 0 {
                    attackerBuffs.atkMultiplier = 1.0
                }
            }
            if attackerBuffs.intBuffRemaining > 0 {
                attackerBuffs.intBuffRemaining -= 1
                if attackerBuffs.intBuffRemaining <= 0 {
                    attackerBuffs.intMultiplier = 1.0
                }
            }
        }
    }

    // MARK: - 피해 계산 (비율 기반 DEF)

    private static func calcDamage(attack: Double, def: Double, dodgeChance: Double) -> Int {
        // 회피 판정
        if dodgeChance > 0 && Double.random(in: 0...1) < dodgeChance {
            return -1   // -1 = 회피
        }
        // 실피해 = attack × (100 / (100 + DEF))
        let reduction = 100.0 / (100.0 + def)
        return max(1, Int(attack * reduction))
    }

    private static func applyDamage(
        _ damage: Int,
        to defender: inout BattleProfile,
        reflectTo attacker: inout BattleProfile,
        reflectRatio: Double,
        log: inout [String],
        attackerName: String,
        defenderName: String,
        skillName: String
    ) {
        if damage == -1 {
            log.append("  \(attackerName) → \(defenderName) \(skillName): 회피!")
            return
        }
        defender.stats.currentHp = max(0, defender.stats.currentHp - damage)
        log.append("  \(attackerName) → \(defenderName) \(skillName): \(damage) 피해 (HP \(defender.stats.currentHp)/\(defender.stats.maxHp))")

        // 반사 처리
        if reflectRatio > 0 {
            let reflected = max(1, Int(Double(damage) * reflectRatio))
            attacker.stats.currentHp = max(0, attacker.stats.currentHp - reflected)
            log.append("  \(defenderName) 반사: \(reflected) 피해 → \(attackerName) (HP \(attacker.stats.currentHp)/\(attacker.stats.maxHp))")
        }
    }

    // MARK: - 선공 결정

    private static func determineFirst(
        mySpd: Int,
        opponentSpd: Int,
        myGuaranteed: Bool,
        opponentGuaranteed: Bool
    ) -> Bool {
        if myGuaranteed && !opponentGuaranteed { return true }
        if opponentGuaranteed && !myGuaranteed { return false }
        if mySpd != opponentSpd { return mySpd > opponentSpd }
        return Bool.random()
    }

    // MARK: - 배틀 보상 계산

    public static func calcReward(
        won: Bool,
        myLevel: Int,
        opponentRarity: Rarity,
        allEquipment: [Equipment]
    ) -> BattleReward {
        let levelMult = 1.0 + Double(myLevel) * 0.1
        let baseXp = won ? 50 : 10
        let xp = Int(Double(baseXp) * levelMult)

        let dropChance = won ? dropChance(for: opponentRarity) : 0.0
        let dropped = Double.random(in: 0...1) < dropChance
            ? randomEquipment(biasedTo: opponentRarity, from: allEquipment)
            : nil

        return BattleReward(xpGained: xp, droppedEquipment: dropped)
    }

    private static func dropChance(for rarity: Rarity) -> Double {
        switch rarity {
        case .common:    return 0.05
        case .rare:      return 0.10
        case .legendary: return 0.15
        case .mythic:    return 0.25
        }
    }

    private static func randomEquipment(biasedTo rarity: Rarity, from all: [Equipment]) -> Equipment? {
        // 상대 레어도 이하 범위에서 랜덤 드롭
        let eligible = all.filter { $0.rarity.dropWeight <= rarity.dropWeight }
        return eligible.randomElement()
    }
}

// MARK: - Rarity Drop Weight

extension Rarity {
    var dropWeight: Int {
        switch self {
        case .common:    return 1
        case .rare:      return 2
        case .legendary: return 3
        case .mythic:    return 4
        }
    }
}
