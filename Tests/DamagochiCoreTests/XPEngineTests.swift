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
