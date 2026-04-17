import Foundation

public struct EvolutionResult: Sendable {
    public let species: Species
    public let personality: String
}

public struct EvolutionEngine: Sendable {
    private let personalityTracker: PersonalityTracker

    public init(personalityTracker: PersonalityTracker = PersonalityTracker()) {
        self.personalityTracker = personalityTracker
    }

    public func determineEvolution(from scores: MbtiScores) -> EvolutionResult {
        let group = personalityTracker.determineMbtiGroup(from: scores)
        let mbtiString = personalityTracker.determineMbtiString(from: scores)
        let species = pickSpecies(for: group, scores: scores)
        return EvolutionResult(species: species, personality: mbtiString)
    }

    func pickSpecies(for group: MbtiGroup, scores: MbtiScores) -> Species {
        let candidates = Species.allSpecies.filter { $0.group == group }
        guard !candidates.isEmpty else { return Species.allSpecies[0] }

        let hash = abs(scores.extroversion &+ scores.intuition &* 7 &+ scores.thinking &* 13 &+ scores.judging &* 31)
        let index = hash % candidates.count
        return candidates[index]
    }

    public func evolve(state: inout PetState) {
        guard state.phase == .egg else { return }

        let result = determineEvolution(from: state.mbtiScores)
        state.phase = .alive
        state.species = result.species.id
        state.personality = result.personality
        state.level = 1
    }

    public func currentStage(level: Int) -> Stage {
        if level >= 26 { return .stage3 }
        if level >= 11 { return .stage2 }
        return .stage1
    }
}
