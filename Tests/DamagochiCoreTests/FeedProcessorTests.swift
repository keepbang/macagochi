import Testing
@testable import DamagochiCore

@Test func feedProcessorAddsXp() {
    let processor = FeedProcessor()
    var state = PetState(machineId: "test")
    let event = BehaviorEvent(kind: .prompt)

    processor.process(event: event, state: &state)
    #expect(state.totalXp == 5)
    #expect(state.totalPrompts == 1)
}

@Test func feedProcessorHatchesAt100Xp() {
    let processor = FeedProcessor()
    var state = PetState(machineId: "test")
    state.xp = 95
    state.totalXp = 95

    let event = BehaviorEvent(kind: .sessionStart)
    let result = processor.process(event: event, state: &state)

    #expect(result.hatched)
    #expect(state.phase == .alive)
    #expect(state.species != nil)
    #expect(state.level == 1)
}

@Test func feedProcessorLevelUpDropsEquipment() {
    let processor = FeedProcessor()
    var state = PetState(machineId: "test")
    state.phase = .alive
    state.level = 1
    state.xp = 95

    let event = BehaviorEvent(kind: .sessionStart)
    let result = processor.process(event: event, state: &state)

    #expect(result.levelsGained == 1)
    #expect(result.droppedEquipment.count == 1)
    #expect(state.inventory.count == 1)
}

@Test func feedProcessorTracksToolUses() {
    let processor = FeedProcessor()
    var state = PetState(machineId: "test")

    let event = BehaviorEvent(kind: .toolUse, metadata: ["tool": "Read"])
    processor.process(event: event, state: &state)

    #expect(state.totalToolUses == 1)
    #expect(state.totalXp == 3)
}

@Test func feedProcessorUpdatesMbti() {
    let processor = FeedProcessor()
    var state = PetState(machineId: "test")

    let event = BehaviorEvent(kind: .toolUse, metadata: ["tool": "Grep"])
    processor.process(event: event, state: &state)

    #expect(state.mbtiScores.thinking == 1)
}

@Test func feedProcessorUnlocksAchievements() {
    let processor = FeedProcessor()
    var state = PetState(machineId: "test")
    state.phase = .alive
    state.level = 4
    state.xp = 245

    let event = BehaviorEvent(kind: .sessionStart)
    let result = processor.process(event: event, state: &state)

    #expect(state.level >= 5)
    let ids = Set(result.newAchievements.map(\.id))
    #expect(ids.contains("level_5"))
}
