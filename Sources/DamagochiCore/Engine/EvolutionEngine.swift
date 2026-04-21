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
        let species = pickSpecies(for: group)
        return EvolutionResult(species: species, personality: mbtiString)
    }

    func pickSpecies(for group: MbtiGroup) -> Species {
        let candidates = Species.allSpecies.filter { $0.group == group }
        guard !candidates.isEmpty else { return Species.allSpecies[0] }

        let totalWeight = candidates.reduce(0) { $0 + rarityWeight($1.rarity) }
        guard totalWeight > 0 else { return candidates[0] }

        let roll = Int.random(in: 0..<totalWeight)
        var cumulative = 0
        for species in candidates {
            cumulative += rarityWeight(species.rarity)
            if roll < cumulative { return species }
        }
        return candidates.last!
    }

    private func rarityWeight(_ rarity: Rarity) -> Int {
        switch rarity {
        case .common:    return 60
        case .rare:      return 25
        case .legendary: return 12
        case .mythic:    return 3
        }
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
