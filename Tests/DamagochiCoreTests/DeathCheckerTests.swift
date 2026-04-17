import Testing
import Foundation
@testable import DamagochiCore

@Test func businessDayCalculation() {
    let checker = DeathChecker()
    let calendar = Calendar.current
    let monday = calendar.date(from: DateComponents(year: 2026, month: 4, day: 13))!
    let friday = calendar.date(from: DateComponents(year: 2026, month: 4, day: 17))!
    #expect(checker.inactiveBusinessDays(lastActive: monday, now: friday) == 4)
}

@Test func weekendsAreSkipped() {
    let checker = DeathChecker()
    let calendar = Calendar.current
    let friday = calendar.date(from: DateComponents(year: 2026, month: 4, day: 10))!
    let nextMonday = calendar.date(from: DateComponents(year: 2026, month: 4, day: 13))!
    #expect(checker.inactiveBusinessDays(lastActive: friday, now: nextMonday) == 1)
}

@Test func warningLevels() {
    let checker = DeathChecker()
    #expect(checker.warningLevel(inactiveBusinessDays: 3) == .none)
    #expect(checker.warningLevel(inactiveBusinessDays: 5) == .warning)
    #expect(checker.warningLevel(inactiveBusinessDays: 9) == .warning)
    #expect(checker.warningLevel(inactiveBusinessDays: 10) == .critical)
    #expect(checker.warningLevel(inactiveBusinessDays: 13) == .critical)
}

@Test func shouldDieAt14Days() {
    let checker = DeathChecker()
    #expect(!checker.shouldDie(inactiveBusinessDays: 13))
    #expect(checker.shouldDie(inactiveBusinessDays: 14))
    #expect(checker.shouldDie(inactiveBusinessDays: 20))
}

@Test func processDeathCreatesGraveyardEntry() {
    let checker = DeathChecker()
    var state = PetState(machineId: "test")
    state.phase = .alive
    state.species = "cat"
    state.level = 10
    state.totalXp = 5000

    let entry = checker.processDeath(state: &state)
    #expect(state.phase == .dead)
    #expect(state.hp == 0)
    #expect(entry.species == "cat")
    #expect(entry.level == 10)
}

@Test func restartCreatesNewEgg() {
    let checker = DeathChecker()
    var state = PetState(machineId: "test")
    state.phase = .dead
    state.level = 15
    state.deathCount = 2

    checker.restart(state: &state)
    #expect(state.phase == .egg)
    #expect(state.level == 0)
    #expect(state.deathCount == 3)
    #expect(state.machineId == "test")
}
