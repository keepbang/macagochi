import Foundation
import DamagochiCore

public final class PetStore: Sendable {
    private static let stateKey = "com.damagochi.petState"

    public init() {}

    public func load() -> PetState? {
        guard let data = UserDefaults.standard.data(forKey: Self.stateKey) else { return nil }
        return try? JSONDecoder().decode(PetState.self, from: data)
    }

    public func save(_ state: PetState) {
        guard let data = try? JSONEncoder().encode(state) else { return }
        UserDefaults.standard.set(data, forKey: Self.stateKey)
    }

    public func reset() {
        UserDefaults.standard.removeObject(forKey: Self.stateKey)
    }
}
