import Testing
@testable import DamagochiCore

@Test func hatchAt100XP() {
    let engine = XPEngine()
    #expect(!engine.shouldHatch(totalXp: 99))
    #expect(engine.shouldHatch(totalXp: 100))
}

@Test func levelUpCalculation() {
    let engine = XPEngine()
    let result = engine.checkLevelUp(currentLevel: 1, currentXp: 100)
    #expect(result.newLevel == 2)
    #expect(result.remainingXp == 0)
}

@Test func stageProgression() {
    let engine = XPEngine()
    #expect(engine.stageForLevel(1) == .stage1)
    #expect(engine.stageForLevel(10) == .stage1)
    #expect(engine.stageForLevel(11) == .stage2)
    #expect(engine.stageForLevel(25) == .stage2)
    #expect(engine.stageForLevel(26) == .stage3)
}

@Test func multiLevelUp() {
    let engine = XPEngine()
    let result = engine.checkLevelUp(currentLevel: 1, currentXp: 250)
    #expect(result.newLevel == 3)
    #expect(result.remainingXp == 0)
}

@Test func noLevelUpWithInsufficientXp() {
    let engine = XPEngine()
    let result = engine.checkLevelUp(currentLevel: 5, currentXp: 10)
    #expect(result.newLevel == 5)
    #expect(result.remainingXp == 10)
}

@Test func xpForEvents() {
    let engine = XPEngine()
    #expect(engine.xpForEvent(BehaviorEvent(kind: .prompt)) == 5)
    #expect(engine.xpForEvent(BehaviorEvent(kind: .toolUse)) == 3)
    #expect(engine.xpForEvent(BehaviorEvent(kind: .sessionStart)) == 10)
}
