import Foundation

public enum MbtiGroup: String, Codable, Sendable {
    case nt
    case nf
    case sj
    case sp
}

public struct Species: Sendable {
    public let id: String
    public let name: String
    public let group: MbtiGroup

    public init(id: String, name: String, group: MbtiGroup) {
        self.id = id
        self.name = name
        self.group = group
    }

    public static let allSpecies: [Species] = [
        Species(id: "owl", name: "올빼미", group: .nt),
        Species(id: "octopus", name: "문어", group: .nt),
        Species(id: "dragon", name: "드래곤", group: .nt),
        Species(id: "wolf", name: "늑대", group: .nt),
        Species(id: "robot", name: "로봇", group: .nt),
        Species(id: "butterfly", name: "나비", group: .nf),
        Species(id: "jellyfish", name: "해바라기", group: .nf),
        Species(id: "cloud", name: "구름", group: .nf),
        Species(id: "fox", name: "여우", group: .nf),
        Species(id: "mushroom", name: "버섯", group: .nf),
        Species(id: "turtle", name: "거북이", group: .sj),
        Species(id: "penguin", name: "팽귄", group: .sj),
        Species(id: "rock", name: "돌", group: .sj),
        Species(id: "cactus", name: "선인장", group: .sj),
        Species(id: "parrot", name: "파리지옥", group: .sj),
        Species(id: "cat", name: "고양이", group: .sp),
        Species(id: "puppy", name: "강아지", group: .sp),
        Species(id: "flame", name: "불꽃", group: .sp),
        Species(id: "bat", name: "박쥐", group: .sp),
        Species(id: "moonrabbit", name: "달팽이", group: .sp),
    ]
}
