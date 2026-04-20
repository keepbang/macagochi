import Foundation

public struct FeedResult: Sendable {
    public var xpGained: Int
    public var hatched: Bool
    public var levelsGained: Int
    public var droppedEquipment: [Equipment]
    public var newAchievements: [Achievement]

    public init(xpGained: Int = 0, hatched: Bool = false, levelsGained: Int = 0,
                droppedEquipment: [Equipment] = [], newAchievements: [Achievement] = []) {
        self.xpGained = xpGained
        self.hatched = hatched
        self.levelsGained = levelsGained
        self.droppedEquipment = droppedEquipment
        self.newAchievements = newAchievements
    }

    public func merged(with other: FeedResult) -> FeedResult {
        FeedResult(
            xpGained: xpGained + other.xpGained,
            hatched: hatched || other.hatched,
            levelsGained: levelsGained + other.levelsGained,
            droppedEquipment: droppedEquipment + other.droppedEquipment,
            newAchievements: newAchievements + other.newAchievements
        )
    }
}

public struct FeedProcessor: Sendable {
    private let xpEngine: XPEngine
    private let healthSystem: HealthSystem
    private let personalityTracker: PersonalityTracker
    private let evolutionEngine: EvolutionEngine
    private let equipmentDropper: EquipmentDropper
    private let achievementChecker: AchievementChecker

    public init(
        xpEngine: XPEngine = XPEngine(),
        healthSystem: HealthSystem = HealthSystem(),
        personalityTracker: PersonalityTracker = PersonalityTracker(),
        evolutionEngine: EvolutionEngine = EvolutionEngine(),
        equipmentDropper: EquipmentDropper = EquipmentDropper(),
        achievementChecker: AchievementChecker = AchievementChecker()
    ) {
        self.xpEngine = xpEngine
        self.healthSystem = healthSystem
        self.personalityTracker = personalityTracker
        self.evolutionEngine = evolutionEngine
        self.equipmentDropper = equipmentDropper
        self.achievementChecker = achievementChecker
    }

    @discardableResult
    public func process(event: BehaviorEvent, state: inout PetState) -> FeedResult {
        let xp = xpEngine.xpForEvent(event)
        state.totalXp += xp
        state.xp += xp
        state.lastActiveAt = event.timestamp

        switch event.kind {
        case .prompt: state.totalPrompts += 1
        case .toolUse: state.totalToolUses += 1
        case .sessionStart: state.totalSessions += 1
        }

        personalityTracker.updateMbti(scores: &state.mbtiScores, event: event)

        var hatched = false
        if state.phase == .egg && xpEngine.shouldHatch(totalXp: state.totalXp) {
            evolutionEngine.evolve(state: &state)
            state.xp = state.totalXp - 100
            hatched = true
        }

        var levelsGained = 0
        var droppedEquipment: [Equipment] = []
        if state.phase == .alive {
            let prevLevel = state.level
            let result = xpEngine.checkLevelUp(currentLevel: state.level, currentXp: state.xp)
            state.level = result.newLevel
            state.xp = result.remainingXp
            levelsGained = state.level - prevLevel

            if levelsGained > 0 {
                for lv in (prevLevel + 1)...(prevLevel + levelsGained) {
                    let item = equipmentDropper.dropEquipment(forLevel: lv)
                    state.inventory.append(item)
                    droppedEquipment.append(item)
                }
            }

            healthSystem.applyRecovery(to: &state)
        }

        let newAchievements = achievementChecker.check(state: state)
        for achievement in newAchievements {
            state.unlockedAchievements.append(achievement.id)
        }

        return FeedResult(
            xpGained: xp,
            hatched: hatched,
            levelsGained: levelsGained,
            droppedEquipment: droppedEquipment,
            newAchievements: newAchievements
        )
    }
}
