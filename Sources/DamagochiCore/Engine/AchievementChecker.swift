import Foundation

public struct AchievementChecker: Sendable {
    public init() {}

    public static let allAchievements: [Achievement] = [
        Achievement(id: "first_hatch", name: "첫 부화", description: "첫 번째 알을 부화시켰다", tier: .bronze),
        Achievement(id: "level_5", name: "초보 개발자", description: "레벨 5에 도달했다", tier: .bronze),
        Achievement(id: "level_10", name: "주니어 개발자", description: "레벨 10에 도달했다", tier: .silver),
        Achievement(id: "level_20", name: "시니어 개발자", description: "레벨 20에 도달했다", tier: .gold),
        Achievement(id: "level_30", name: "아키텍트", description: "레벨 30에 도달했다", tier: .diamond),
        Achievement(id: "stage_2", name: "성장기", description: "Stage 2에 진입했다", tier: .silver),
        Achievement(id: "stage_3", name: "완전체", description: "Stage 3에 진입했다", tier: .gold),
        Achievement(id: "equip_3", name: "장비 수집가", description: "장비 3개를 모았다", tier: .bronze),
        Achievement(id: "equip_10", name: "장비 마니아", description: "장비 10개를 모았다", tier: .silver),
        Achievement(id: "equip_legendary", name: "전설 획득", description: "전설 등급 장비를 획득했다", tier: .gold),
        Achievement(id: "equip_mythic", name: "신화 획득", description: "신화 등급 장비를 획득했다", tier: .diamond),
        Achievement(id: "prompts_100", name: "대화의 달인", description: "프롬프트 100회 제출", tier: .bronze),
        Achievement(id: "prompts_1000", name: "끝없는 대화", description: "프롬프트 1000회 제출", tier: .gold),
        Achievement(id: "sessions_10", name: "단골 손님", description: "세션 10회 시작", tier: .bronze),
        Achievement(id: "sessions_100", name: "상주 개발자", description: "세션 100회 시작", tier: .silver),
        Achievement(id: "workdays_7", name: "일주일 연속", description: "7 영업일 연속 사용", tier: .bronze),
        Achievement(id: "workdays_30", name: "한 달 연속", description: "30 영업일 연속 사용", tier: .silver),
        Achievement(id: "workdays_100", name: "백일의 약속", description: "100 영업일 연속 사용", tier: .diamond),
        Achievement(id: "rebirth", name: "불사조", description: "사망 후 다시 시작했다", tier: .silver),
        Achievement(id: "xp_10000", name: "경험의 대가", description: "총 XP 10,000 달성", tier: .gold),
    ]

    public func check(state: PetState) -> [Achievement] {
        let unlocked = Set(state.unlockedAchievements)
        var newlyUnlocked: [Achievement] = []

        for achievement in Self.allAchievements {
            guard !unlocked.contains(achievement.id) else { continue }
            if isSatisfied(achievement: achievement, state: state) {
                var a = achievement
                a.unlockedAt = Date()
                newlyUnlocked.append(a)
            }
        }
        return newlyUnlocked
    }

    private func isSatisfied(achievement: Achievement, state: PetState) -> Bool {
        switch achievement.id {
        case "first_hatch":
            return state.phase == .alive && state.level >= 1
        case "level_5":
            return state.level >= 5
        case "level_10":
            return state.level >= 10
        case "level_20":
            return state.level >= 20
        case "level_30":
            return state.level >= 30
        case "stage_2":
            return state.level >= 11
        case "stage_3":
            return state.level >= 26
        case "equip_3":
            return state.inventory.count >= 3
        case "equip_10":
            return state.inventory.count >= 10
        case "equip_legendary":
            return state.inventory.contains { $0.rarity == .legendary }
        case "equip_mythic":
            return state.inventory.contains { $0.rarity == .mythic }
        case "prompts_100":
            return state.totalPrompts >= 100
        case "prompts_1000":
            return state.totalPrompts >= 1000
        case "sessions_10":
            return state.totalSessions >= 10
        case "sessions_100":
            return state.totalSessions >= 100
        case "workdays_7":
            return state.consecutiveWorkdays >= 7
        case "workdays_30":
            return state.consecutiveWorkdays >= 30
        case "workdays_100":
            return state.consecutiveWorkdays >= 100
        case "rebirth":
            return state.deathCount >= 1 && state.phase == .egg
        case "xp_10000":
            return state.totalXp >= 10000
        default:
            return false
        }
    }
}
