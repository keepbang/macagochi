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
    public let rarity: Rarity

    public init(id: String, name: String, group: MbtiGroup, rarity: Rarity) {
        self.id = id
        self.name = name
        self.group = group
        self.rarity = rarity
    }

    public static let allSpecies: [Species] = [
        // NT
        Species(id: "owl",      name: "올빼미",  group: .nt, rarity: .common),
        Species(id: "wolf",     name: "늑대",    group: .nt, rarity: .common),
        Species(id: "octopus",  name: "문어",    group: .nt, rarity: .rare),
        Species(id: "dragon",   name: "드래곤",  group: .nt, rarity: .legendary),
        Species(id: "robot",    name: "로봇",    group: .nt, rarity: .mythic),
        // NF
        Species(id: "butterfly", name: "나비",   group: .nf, rarity: .common),
        Species(id: "cloud",    name: "구름",    group: .nf, rarity: .common),
        Species(id: "jellyfish", name: "해파리", group: .nf, rarity: .rare),
        Species(id: "fox",      name: "여우",    group: .nf, rarity: .rare),
        Species(id: "mushroom", name: "버섯",    group: .nf, rarity: .legendary),
        // SJ
        Species(id: "turtle",   name: "거북이",  group: .sj, rarity: .common),
        Species(id: "penguin",  name: "팽귄",    group: .sj, rarity: .common),
        Species(id: "rock",     name: "돌",      group: .sj, rarity: .rare),
        Species(id: "cactus",   name: "선인장",  group: .sj, rarity: .rare),
        Species(id: "parrot",   name: "파리지옥", group: .sj, rarity: .legendary),
        // SP
        Species(id: "cat",      name: "고양이",  group: .sp, rarity: .common),
        Species(id: "puppy",    name: "강아지",  group: .sp, rarity: .common),
        Species(id: "flame",    name: "불꽃",    group: .sp, rarity: .rare),
        Species(id: "bat",      name: "박쥐",    group: .sp, rarity: .rare),
        Species(id: "moonrabbit", name: "달토끼", group: .sp, rarity: .mythic),
    ]
}
