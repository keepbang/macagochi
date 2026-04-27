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
        // NT - Analytical / Theoretical
        Species(id: "owl",       name: "올빼미",   group: .nt, rarity: .common),
        Species(id: "wolf",      name: "늑대",     group: .nt, rarity: .common),
        Species(id: "crystal",   name: "수정",     group: .nt, rarity: .common),
        Species(id: "octopus",   name: "문어",     group: .nt, rarity: .rare),
        Species(id: "android",   name: "안드로이드", group: .nt, rarity: .rare),
        Species(id: "phoenix",   name: "불사조",   group: .nt, rarity: .rare),
        Species(id: "dragon",    name: "드래곤",   group: .nt, rarity: .legendary),
        Species(id: "sphinx",    name: "스핑크스",  group: .nt, rarity: .legendary),
        Species(id: "robot",     name: "로봇",     group: .nt, rarity: .mythic),
        Species(id: "nebula",    name: "성운",     group: .nt, rarity: .mythic),
        // NF - Idealistic / Creative
        Species(id: "butterfly", name: "나비",     group: .nf, rarity: .common),
        Species(id: "cloud",     name: "구름",     group: .nf, rarity: .common),
        Species(id: "lotus",     name: "연꽃",     group: .nf, rarity: .common),
        Species(id: "jellyfish", name: "해파리",   group: .nf, rarity: .rare),
        Species(id: "fox",       name: "여우",     group: .nf, rarity: .rare),
        Species(id: "unicorn",   name: "유니콘",   group: .nf, rarity: .rare),
        Species(id: "mushroom",  name: "버섯",     group: .nf, rarity: .legendary),
        Species(id: "fairy",     name: "요정",     group: .nf, rarity: .legendary),
        Species(id: "celestial", name: "천상",     group: .nf, rarity: .mythic),
        Species(id: "aurora",    name: "오로라",   group: .nf, rarity: .mythic),
        // SJ - Traditional / Responsible
        Species(id: "turtle",    name: "거북이",   group: .sj, rarity: .common),
        Species(id: "penguin",   name: "펭귄",     group: .sj, rarity: .common),
        Species(id: "bear",      name: "곰",       group: .sj, rarity: .common),
        Species(id: "rock",      name: "돌",       group: .sj, rarity: .rare),
        Species(id: "cactus",    name: "선인장",   group: .sj, rarity: .rare),
        Species(id: "hedgehog",  name: "고슴도치",  group: .sj, rarity: .rare),
        Species(id: "parrot",    name: "파리지옥",  group: .sj, rarity: .legendary),
        Species(id: "golem",     name: "골렘",     group: .sj, rarity: .legendary),
        Species(id: "elephant",  name: "코끼리",   group: .sj, rarity: .mythic),
        Species(id: "kraken",    name: "크라켄",   group: .sj, rarity: .mythic),
        // SP - Adventurous / Free
        Species(id: "cat",       name: "고양이",   group: .sp, rarity: .common),
        Species(id: "puppy",     name: "강아지",   group: .sp, rarity: .common),
        Species(id: "rabbit",    name: "토끼",     group: .sp, rarity: .common),
        Species(id: "flame",     name: "불꽃",     group: .sp, rarity: .rare),
        Species(id: "bat",       name: "박쥐",     group: .sp, rarity: .rare),
        Species(id: "scorpion",  name: "전갈",     group: .sp, rarity: .rare),
        Species(id: "fish",      name: "물고기",   group: .sp, rarity: .legendary),
        Species(id: "lightning", name: "번개",     group: .sp, rarity: .legendary),
        Species(id: "moonrabbit", name: "달토끼",  group: .sp, rarity: .mythic),
        Species(id: "comet",     name: "혜성",     group: .sp, rarity: .mythic),
    ]
}
