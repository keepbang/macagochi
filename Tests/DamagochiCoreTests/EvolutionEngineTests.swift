import Testing
@testable import DamagochiCore

@Test func ntGroupDetermination() {
    let tracker = PersonalityTracker()
    let scores = MbtiScores(extroversion: 5, intuition: 3, thinking: 4, judging: 2)
    #expect(tracker.determineMbtiGroup(from: scores) == .nt)
}

@Test func nfGroupDetermination() {
    let tracker = PersonalityTracker()
    let scores = MbtiScores(extroversion: 0, intuition: 1, thinking: -3, judging: 0)
    #expect(tracker.determineMbtiGroup(from: scores) == .nf)
}

@Test func sjGroupDetermination() {
    let tracker = PersonalityTracker()
    let scores = MbtiScores(extroversion: 0, intuition: -2, thinking: 1, judging: 0)
    #expect(tracker.determineMbtiGroup(from: scores) == .sj)
}

@Test func spGroupDetermination() {
    let tracker = PersonalityTracker()
    let scores = MbtiScores(extroversion: 0, intuition: -1, thinking: -1, judging: 0)
    #expect(tracker.determineMbtiGroup(from: scores) == .sp)
}

@Test func mbtiStringGeneration() {
    let tracker = PersonalityTracker()
    let scores = MbtiScores(extroversion: 5, intuition: -3, thinking: 2, judging: -1)
    #expect(tracker.determineMbtiString(from: scores) == "ESTP")
}

@Test func evolutionPicksSpeciesFromCorrectGroup() {
    let engine = EvolutionEngine()
    let ntScores = MbtiScores(extroversion: 1, intuition: 5, thinking: 3, judging: 1)
    let result = engine.determineEvolution(from: ntScores)

    let ntSpecies = Species.allSpecies.filter { $0.group == .nt }
    #expect(ntSpecies.contains { $0.id == result.species.id })
}

@Test func evolveChangesPhaseToAlive() {
    let engine = EvolutionEngine()
    var state = PetState(machineId: "test")
    state.phase = .egg
    state.mbtiScores = MbtiScores(extroversion: 1, intuition: 2, thinking: 3, judging: 4)

    engine.evolve(state: &state)
    #expect(state.phase == .alive)
    #expect(state.level == 1)
    #expect(state.species != nil)
    #expect(state.personality != nil)
}

@Test func evolveDoesNothingIfAlreadyAlive() {
    let engine = EvolutionEngine()
    var state = PetState(machineId: "test")
    state.phase = .alive
    state.level = 5
    state.species = "cat"

    engine.evolve(state: &state)
    #expect(state.level == 5)
    #expect(state.species == "cat")
}

@Test func stageForLevel() {
    let engine = EvolutionEngine()
    #expect(engine.currentStage(level: 1) == .stage1)
    #expect(engine.currentStage(level: 10) == .stage1)
    #expect(engine.currentStage(level: 11) == .stage2)
    #expect(engine.currentStage(level: 25) == .stage2)
    #expect(engine.currentStage(level: 26) == .stage3)
}
