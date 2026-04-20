import DamagochiCore

public enum SpriteSheet {

    public static func frames(
        species: String?,
        stage: Stage,
        phase: PetPhase
    ) -> [PixelSprite] {
        switch phase {
        case .egg:
            return eggFrames
        case .dead:
            return aliveFrames(species: species, stage: stage).map { $0.grayed() }
        case .alive:
            return aliveFrames(species: species, stage: stage)
        }
    }

    private static func aliveFrames(species: String?, stage: Stage) -> [PixelSprite] {
        guard let species else { return eggFrames }
        switch species {
        case "owl":       return owlFrames(stage)
        case "cat":       return catFrames(stage)
        case "turtle":    return turtleFrames(stage)
        case "butterfly": return butterflyFrames(stage)
        case "dragon":    return dragonFrames(stage)
        default:          return defaultFrames(stage)
        }
    }

    // MARK: - Helpers

    private static func s(_ palette: [Character: PixelColor], _ rows: [String]) -> PixelSprite {
        PixelSprite(palette: palette, rows: rows)
    }

    // MARK: - Egg

    private static let eggPalette: [Character: PixelColor] = [
        ".": .clear, "#": .tan, "c": .cream, "y": .gold, "w": .white,
    ]

    static let eggFrames: [PixelSprite] = [
        s(eggPalette, [
            "................",
            ".....######.....",
            "....#cccccc#....",
            "...#cccccccc#...",
            "..#cccccccccc#..",
            "..#ccy##ccccc#..",
            "..#cy####cccc#..",
            "..#cccccccccc#..",
            "..#cccccccccc#..",
            "..#ccccc##ycc#..",
            "..#cccc####yc#..",
            "...#cccccccc#...",
            "....#cccccc#....",
            ".....######.....",
            "................",
            "................",
        ]),
        s(eggPalette, [
            "................",
            "......######....",
            ".....#cccccc#...",
            "....#cccccccc#..",
            "...#cccccccccc#.",
            "...#ccy##ccccc#.",
            "...#cy####cccc#.",
            "...#cccccccccc#.",
            "...#cccccccccc#.",
            "...#ccccc##ycc#.",
            "...#cccc####yc#.",
            "....#cccccccc#..",
            ".....#cccccc#...",
            "......######....",
            "................",
            "................",
        ]),
    ]

    // MARK: - Owl

    private static let owlPalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "b": .brown, "t": .tan,
        "w": .white, "o": .orange, "y": .yellow,
    ]

    private static func owlFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return owlStage1
        case .stage2: return owlStage2
        case .stage3: return owlStage3
        }
    }

    private static let owlStage1: [PixelSprite] = [
        s(owlPalette, [
            "................",
            "................",
            "................",
            "....#......#....",
            "...##......##...",
            "...##########...",
            "..#bbbbbbbbbb#..",
            "..#bw##bb##wb#..",
            "..#bo##bb##ob#..",
            "..#bbbb##bbbb#..",
            "..#bbb#oo#bbb#..",
            "...#bbttttbb#...",
            "....#bb##bb#....",
            "...##......##...",
            "................",
            "................",
        ]),
        s(owlPalette, [
            "................",
            "................",
            "................",
            "....#......#....",
            "...##......##...",
            "...##########...",
            "..#bbbbbbbbbb#..",
            "..#b##bbbb##b#..",
            "..#bbbbbbbbbb#..",
            "..#bbbb##bbbb#..",
            "..#bbb#oo#bbb#..",
            "...#bbttttbb#...",
            "....#bb##bb#....",
            "...##......##...",
            "................",
            "................",
        ]),
    ]

    private static let owlStage2: [PixelSprite] = [
        s(owlPalette, [
            "................",
            "...#........#...",
            "..##........##..",
            "..############..",
            ".#bbbbbbbbbbbb#.",
            ".#bww##bb##wwb#.",
            ".#bwo##bb##owb#.",
            ".#bbbb####bbbb#.",
            "..#bbb#oo#bbb#..",
            "..#bbbbbbbbbb#..",
            "..#bbttttttbb#..",
            "...#bbbbbbbb#...",
            "...#bb#..#bb#...",
            "..##........##..",
            "................",
            "................",
        ]),
        s(owlPalette, [
            "................",
            "...#........#...",
            "..##........##..",
            "..############..",
            ".#bbbbbbbbbbbb#.",
            ".#b####bb####b#.",
            ".#bbbbbbbbbbbb#.",
            ".#bbbb####bbbb#.",
            "..#bbb#oo#bbb#..",
            "..#bbbbbbbbbb#..",
            "..#bbttttttbb#..",
            "...#bbbbbbbb#...",
            "...#bb#..#bb#...",
            "..##........##..",
            "................",
            "................",
        ]),
    ]

    private static let owlStage3: [PixelSprite] = [
        s(owlPalette, [
            "..#..........#..",
            ".##..........##.",
            ".##############.",
            "#bbbbbbbbbbbbbb#",
            "#bww##bbbb##wwb#",
            "#bwo##bbbb##owb#",
            "#bbbb######bbbb#",
            "#bbbbb#oo#bbbbb#",
            ".#bbbbbbbbbbbb#.",
            ".#bbttttttttbb#.",
            "..#bttttttttb#..",
            "..#bbbbbbbbbb#..",
            "...#bbb##bbb#...",
            "..##........##..",
            "................",
            "................",
        ]),
        s(owlPalette, [
            "..#..........#..",
            ".##..........##.",
            ".##############.",
            "#bbbbbbbbbbbbbb#",
            "#b####bbbb####b#",
            "#bbbbbbbbbbbbbb#",
            "#bbbb######bbbb#",
            "#bbbbb#oo#bbbbb#",
            ".#bbbbbbbbbbbb#.",
            ".#bbttttttttbb#.",
            "..#bttttttttb#..",
            "..#bbbbbbbbbb#..",
            "...#bbb##bbb#...",
            "..##........##..",
            "................",
            "................",
        ]),
    ]

    // MARK: - Cat

    private static let catPalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "o": .ginger,
        "w": .white, "p": .pink, "g": .green,
    ]

    private static func catFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return catStage1
        case .stage2: return catStage2
        case .stage3: return catStage3
        }
    }

    private static let catStage1: [PixelSprite] = [
        s(catPalette, [
            "................",
            "................",
            "................",
            "....#......#....",
            "...#o#....#o#...",
            "...#oo####oo#...",
            "..#oooooooooo#..",
            "..#ow##oo##wo#..",
            "..#ooo#pp#ooo#..",
            "..#oowwwwwwoo#..",
            "...#oooooooo#...",
            "....#oo##oo#....",
            "...##......##...",
            "................",
            "................",
            "................",
        ]),
        s(catPalette, [
            "................",
            "................",
            "................",
            "....#......#....",
            "...#o#....#o#...",
            "...#oo####oo#...",
            "..#oooooooooo#..",
            "..#o##oooo##o#..",
            "..#ooo#pp#ooo#..",
            "..#oowwwwwwoo#..",
            "...#oooooooo#...",
            "....#oo##oo#....",
            "...##......##...",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let catStage2: [PixelSprite] = [
        s(catPalette, [
            "................",
            "...#........#...",
            "..#o#......#o#..",
            ".#ooo######ooo#.",
            ".#oooooooooooo#.",
            "#oww##oooo##wwo#",
            "#owg##oooo##gwo#",
            "#ooooo#pp#ooooo#",
            ".#oooooooooooo#.",
            ".#oowwwwwwwwoo#.",
            "..#owwwwwwwwo#..",
            "..#oooooooooo#..",
            "...#ooo##ooo#...",
            "..##........##..",
            "................",
            "................",
        ]),
        s(catPalette, [
            "................",
            "...#........#...",
            "..#o#......#o#..",
            ".#ooo######ooo#.",
            ".#oooooooooooo#.",
            "#o####oooo####o#",
            "#oooooooooooooo#",
            "#ooooo#pp#ooooo#",
            ".#oooooooooooo#.",
            ".#oowwwwwwwwoo#.",
            "..#owwwwwwwwo#..",
            "..#oooooooooo#..",
            "...#ooo##ooo#...",
            "..##........##..",
            "................",
            "................",
        ]),
    ]

    private static let catStage3: [PixelSprite] = [
        s(catPalette, [
            "...#........#...",
            "..#o#......#o#..",
            ".#ooo######ooo#.",
            ".#oooooooooooo#.",
            "#oww##oooo##wwo#",
            "#owg##oooo##gwo#",
            "#oooooo##oooooo#",
            "#ooooo#pp#ooooo#",
            ".#oooooooooooo#.",
            ".#oowwwwwwwwoo#.",
            "..#owwwwwwwwo#..",
            "..#oooooooooo#..",
            "...#ooo##ooo#...",
            "..##........##..",
            "................",
            "................",
        ]),
        s(catPalette, [
            "...#........#...",
            "..#o#......#o#..",
            ".#ooo######ooo#.",
            ".#oooooooooooo#.",
            "#o####oooo####o#",
            "#oooooooooooooo#",
            "#oooooo##oooooo#",
            "#ooooo#pp#ooooo#",
            ".#oooooooooooo#.",
            ".#oowwwwwwwwoo#.",
            "..#owwwwwwwwo#..",
            "..#oooooooooo#..",
            "...#ooo##ooo#...",
            "..##........##..",
            "................",
            "................",
        ]),
    ]

    // MARK: - Turtle

    private static let turtlePalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "g": .green,
        "d": .darkGreen, "t": .tan, "w": .white,
    ]

    private static func turtleFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return turtleStage1
        case .stage2: return turtleStage2
        case .stage3: return turtleStage3
        }
    }

    private static let turtleStage1: [PixelSprite] = [
        s(turtlePalette, [
            "................",
            "................",
            "................",
            "......####......",
            ".....#tttt#.....",
            ".....#t##t#.....",
            ".....#tttt#.....",
            "....########....",
            "...#dddddddd#...",
            "...#dgddddgd#...",
            "...#dddddddd#...",
            "....########....",
            "....#t#..#t#....",
            "................",
            "................",
            "................",
        ]),
        s(turtlePalette, [
            "................",
            "................",
            "................",
            "......####......",
            ".....#tttt#.....",
            ".....######.....",
            ".....#tttt#.....",
            "....########....",
            "...#dddddddd#...",
            "...#dgddddgd#...",
            "...#dddddddd#...",
            "....########....",
            "....#t#..#t#....",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let turtleStage2: [PixelSprite] = [
        s(turtlePalette, [
            "................",
            ".....######.....",
            "....#tttttt#....",
            "....#tw##wt#....",
            "....#tttttt#....",
            "...##########...",
            "..#dddddddddd#..",
            "..#dgddddddgd#..",
            "..#ddggggggdd#..",
            "..#dgddddddgd#..",
            "..#dddddddddd#..",
            "...##########...",
            "...#tt#..#tt#...",
            "..##........##..",
            "................",
            "................",
        ]),
        s(turtlePalette, [
            "................",
            ".....######.....",
            "....#tttttt#....",
            "....########....",
            "....#tttttt#....",
            "...##########...",
            "..#dddddddddd#..",
            "..#dgddddddgd#..",
            "..#ddggggggdd#..",
            "..#dgddddddgd#..",
            "..#dddddddddd#..",
            "...##########...",
            "...#tt#..#tt#...",
            "..##........##..",
            "................",
            "................",
        ]),
    ]

    private static let turtleStage3: [PixelSprite] = [
        s(turtlePalette, [
            "......####......",
            ".....#tttt#.....",
            "....#tttttt#....",
            "....#tw##wt#....",
            "....#tttttt#....",
            "...##########...",
            "..#dddddddddd#..",
            "..#dgddddddgd#..",
            "..#ddggggggdd#..",
            ".#dggddddddggd#.",
            ".#dgddddddddgd#.",
            "..#dddddddddd#..",
            "...##########...",
            "....#tt##tt#....",
            "...##......##...",
            "................",
        ]),
        s(turtlePalette, [
            "......####......",
            ".....#tttt#.....",
            "....#tttttt#....",
            "....########....",
            "....#tttttt#....",
            "...##########...",
            "..#dddddddddd#..",
            "..#dgddddddgd#..",
            "..#ddggggggdd#..",
            ".#dggddddddggd#.",
            ".#dgddddddddgd#.",
            "..#dddddddddd#..",
            "...##########...",
            "....#tt##tt#....",
            "...##......##...",
            "................",
        ]),
    ]

    // MARK: - Butterfly

    private static let bflyPalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "p": .purple,
        "b": .blue, "l": .lavender, "k": .pink, "w": .white,
    ]

    private static func butterflyFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return bflyStage1
        case .stage2: return bflyStage2
        case .stage3: return bflyStage3
        }
    }

    // Stage 1: caterpillar
    private static let bflyStage1: [PixelSprite] = [
        s(["." : .clear, "#": .black, "g": .green, "l": .lime, "w": .white], [
            "................",
            "................",
            "................",
            "................",
            ".....#....#.....",
            "......#..#......",
            ".....######.....",
            "....#gggggg#....",
            "....#gw##wg#....",
            "....#gggggg#....",
            "...#llggggll#...",
            "...#llllllll#...",
            "...#llggggll#...",
            "....########....",
            "................",
            "................",
        ]),
        s(["." : .clear, "#": .black, "g": .green, "l": .lime, "w": .white], [
            "................",
            "................",
            "................",
            "................",
            "....#......#....",
            ".....#....#.....",
            ".....######.....",
            "....#gggggg#....",
            "....#gw##wg#....",
            "....#gggggg#....",
            "...#llggggll#...",
            "...#llllllll#...",
            "...#llggggll#...",
            "....########....",
            "................",
            "................",
        ]),
    ]

    // Stage 2: chrysalis
    private static let bflyStage2: [PixelSprite] = [
        s(bflyPalette, [
            "................",
            "................",
            "......####......",
            ".....#pppp#.....",
            "....#pppppp#....",
            "....#plpppl#....",
            "....#pppppp#....",
            "....#plpppl#....",
            "....#pppppp#....",
            "....#pppppp#....",
            ".....#pppp#.....",
            "......####......",
            ".......##.......",
            "................",
            "................",
            "................",
        ]),
        s(bflyPalette, [
            "................",
            "................",
            "......####......",
            ".....#pppp#.....",
            "....#pppppp#....",
            "....#plpppl#....",
            "....#pppppp#....",
            "....#ppllpp#....",
            "....#pppppp#....",
            "....#pppppp#....",
            ".....#pppp#.....",
            "......####......",
            ".......##.......",
            "................",
            "................",
            "................",
        ]),
    ]

    // Stage 3: full butterfly
    private static let bflyStage3: [PixelSprite] = [
        s(bflyPalette, [
            "................",
            ".....#....#.....",
            "......#..#......",
            ".##...####...##.",
            "#pp#..#bb#..#pp#",
            "#ppp#.#bb#.#ppp#",
            "#pppp##bb##pppp#",
            "#plpp##bb##pplp#",
            "#pppp##bb##pppp#",
            "#ppp#.#bb#.#ppp#",
            ".##...#bb#...##.",
            "......#bb#......",
            ".......##.......",
            "................",
            "................",
            "................",
        ]),
        s(bflyPalette, [
            "................",
            ".....#....#.....",
            ".##...#..#...##.",
            "#pp#..####..#pp#",
            "#ppp#.#bb#.#ppp#",
            "#pppp##bb##pppp#",
            "#plpp##bb##pplp#",
            "#pppp##bb##pppp#",
            "#ppp#.#bb#.#ppp#",
            ".##...#bb#...##.",
            "......#bb#......",
            ".......##.......",
            "................",
            "................",
            "................",
            "................",
        ]),
    ]

    // MARK: - Dragon

    private static let dragonPalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "r": .red,
        "o": .orange, "y": .yellow, "w": .white, "d": .darkRed,
    ]

    private static func dragonFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return dragonStage1
        case .stage2: return dragonStage2
        case .stage3: return dragonStage3
        }
    }

    private static let dragonStage1: [PixelSprite] = [
        s(dragonPalette, [
            "................",
            "................",
            "................",
            "....#......#....",
            "...##......##...",
            "...##########...",
            "..#rrrrrrrrrr#..",
            "..#rw##rr##wr#..",
            "..#rrrr##rrrr#..",
            "..#rrr#yy#rrr#..",
            "...#rrooooorr#..",
            "...#rrrrrrrr#...",
            "....#rr##rr#....",
            "...##......##...",
            "................",
            "................",
        ]),
        s(dragonPalette, [
            "................",
            "................",
            "................",
            "....#......#....",
            "...##......##...",
            "...##########...",
            "..#rrrrrrrrrr#..",
            "..#r##rrrr##r#..",
            "..#rrrr##rrrr#..",
            "..#rrr#yy#rrr#..",
            "...#rrooooorr#..",
            "...#rrrrrrrr#...",
            "....#rr##rr#....",
            "...##......##...",
            "................",
            "................",
        ]),
    ]

    private static let dragonStage2: [PixelSprite] = [
        s(dragonPalette, [
            "................",
            "..#..........#..",
            ".##..........##.",
            ".##############.",
            "#rrrrrrrrrrrrrr#",
            "#rww##rrrr##wwr#",
            "#rrrr######rrrr#",
            ".#rrrr#yy#rrrr#.",
            "..#rrrrrrrrrr#..",
            "..#rroooooorrr#.",
            "...#oooooooo#...",
            "...#rrrrrrrr#...",
            "....#rr##rr#....",
            "...##......##...",
            "................",
            "................",
        ]),
        s(dragonPalette, [
            "................",
            "..#..........#..",
            ".##..........##.",
            ".##############.",
            "#rrrrrrrrrrrrrr#",
            "#r####rrrr####r#",
            "#rrrr######rrrr#",
            ".#rrrr#yy#rrrr#.",
            "..#rrrrrrrrrr#..",
            "..#rroooooorrr#.",
            "...#oooooooo#...",
            "...#rrrrrrrr#...",
            "....#rr##rr#....",
            "...##......##...",
            "................",
            "................",
        ]),
    ]

    private static let dragonStage3: [PixelSprite] = [
        s(dragonPalette, [
            "..#..........#..",
            ".##..........##.",
            ".##############.",
            "#rrrrrrrrrrrrrr#",
            "#rww##rrrr##wwr#",
            "#rrrr######rrrr#",
            ".#rrrr#yy#rrrr#.",
            "..#rrrrrrrrrr#..",
            "..#rroooooorr#..",
            "..#roooooooor#..",
            "...#oooooooo#...",
            "...#rrrrrrrr#...",
            "....#rr##rr#....",
            "...##......##...",
            "................",
            "................",
        ]),
        s(dragonPalette, [
            "..#..........#..",
            ".##..........##.",
            ".##############.",
            "#rrrrrrrrrrrrrr#",
            "#r####rrrr####r#",
            "#rrrr######rrrr#",
            ".#rrrr#yy#rrrr#.",
            "..#rrrrrrrrrr#..",
            "..#rroooooorr#..",
            "..#roooooooor#..",
            "...#oooooooo#...",
            "...#rrrrrrrr#...",
            "....#rr##rr#....",
            "...##......##...",
            "................",
            "................",
        ]),
    ]

    // MARK: - Default (blob for unmapped species)

    private static func defaultFrames(_ stage: Stage) -> [PixelSprite] {
        let palette: [Character: PixelColor] = [
            ".": .clear, "#": .black, "b": .blue, "l": .lightGray, "w": .white,
        ]
        switch stage {
        case .stage1:
            return [
                s(palette, [
                    "................",
                    "................",
                    "................",
                    "................",
                    ".....######.....",
                    "....#bbbbbb#....",
                    "...#bbw##wbb#...",
                    "...#bbbbbbbb#...",
                    "...#bbbbbbbb#...",
                    "....#bbbbbb#....",
                    ".....######.....",
                    "................",
                    "................",
                    "................",
                    "................",
                    "................",
                ]),
                s(palette, [
                    "................",
                    "................",
                    "................",
                    "................",
                    "......######....",
                    ".....#bbbbbb#...",
                    "....#bbw##wbb#..",
                    "....#bbbbbbbb#..",
                    "....#bbbbbbbb#..",
                    ".....#bbbbbb#...",
                    "......######....",
                    "................",
                    "................",
                    "................",
                    "................",
                    "................",
                ]),
            ]
        case .stage2:
            return [
                s(palette, [
                    "................",
                    "................",
                    "....########....",
                    "...#bbbbbbbb#...",
                    "..#bbww##wwbb#..",
                    "..#bbbbbbbbbb#..",
                    "..#bbbbbbbbbb#..",
                    "..#bbllllllbb#..",
                    "...#bbbbbbbb#...",
                    "....########....",
                    "................",
                    "................",
                    "................",
                    "................",
                    "................",
                    "................",
                ]),
                s(palette, [
                    "................",
                    "................",
                    ".....########...",
                    "....#bbbbbbbb#..",
                    "...#bbww##wwbb#.",
                    "...#bbbbbbbbbb#.",
                    "...#bbbbbbbbbb#.",
                    "...#bbllllllbb#.",
                    "....#bbbbbbbb#..",
                    ".....########...",
                    "................",
                    "................",
                    "................",
                    "................",
                    "................",
                    "................",
                ]),
            ]
        case .stage3:
            return [
                s(palette, [
                    "................",
                    "...##########...",
                    "..#bbbbbbbbbb#..",
                    ".#bbbbbbbbbbbb#.",
                    "#bbwww##wwwbbb##",
                    "#bbbbb####bbbbb#",
                    "#bbbbbbbbbbbbbb#",
                    "#bbbllllllllbbb#",
                    "#bbblllllllbbbb#",
                    ".#bbbbbbbbbbbb#.",
                    "..#bbbbbbbbbb#..",
                    "...##########...",
                    "................",
                    "................",
                    "................",
                    "................",
                ]),
                s(palette, [
                    "................",
                    "....##########..",
                    "...#bbbbbbbbbb#.",
                    "..#bbbbbbbbbbbb#",
                    ".#bbwww##wwwbbb#",
                    ".#bbbbb####bbbb#",
                    ".#bbbbbbbbbbbb#.",
                    ".#bbbllllllllbb#",
                    ".#bbblllllllbbb#",
                    "..#bbbbbbbbbbbb#",
                    "...#bbbbbbbbbb#.",
                    "....##########..",
                    "................",
                    "................",
                    "................",
                    "................",
                ]),
            ]
        }
    }

    // MARK: - Equipment Overlays

    public static func frames(
        species: String?,
        stage: Stage,
        phase: PetPhase,
        equipped: EquippedItems,
        inventory: [Equipment]
    ) -> [PixelSprite] {
        let base = frames(species: species, stage: stage, phase: phase)
        guard phase == .alive else { return base }

        let overlayList: [PixelSprite] = [
            equipped.head.flatMap { id in inventory.first { $0.id == id } }.map { headOverlay(rarity: $0.rarity) },
            equipped.hand.flatMap { id in inventory.first { $0.id == id } }.map { handOverlay(rarity: $0.rarity) },
            equipped.effect.flatMap { id in inventory.first { $0.id == id } }.map { effectOverlay(rarity: $0.rarity) },
        ].compactMap { $0 }

        guard !overlayList.isEmpty else { return base }
        return base.map { frame in overlayList.reduce(frame) { $0.overlaid(with: $1) } }
    }

    private static func headOverlay(rarity: Rarity) -> PixelSprite {
        switch rarity {
        case .common:    return headCommon
        case .rare:      return headRare
        case .legendary: return headLegendary
        case .mythic:    return headMythic
        }
    }

    private static func handOverlay(rarity: Rarity) -> PixelSprite {
        switch rarity {
        case .common:    return handCommon
        case .rare:      return handRare
        case .legendary: return handLegendary
        case .mythic:    return handMythic
        }
    }

    private static func effectOverlay(rarity: Rarity) -> PixelSprite {
        switch rarity {
        case .common:    return effectCommon
        case .rare:      return effectRare
        case .legendary: return effectLegendary
        case .mythic:    return effectMythic
        }
    }

    private static let headCommon = s(
        [".": .clear, "#": .black, "b": .blue],
        [
            "................",
            ".....######.....",
            "....#bbbbbb#....",
            "....#bbbbbb#....",
            "...##########...",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
        ]
    )

    private static let headRare = s(
        [".": .clear, "#": .black, "y": .yellow, "g": .gold],
        [
            "....#...#...#...",
            "....#########...",
            "...#ggggggggg#..",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
        ]
    )

    private static let headLegendary = s(
        [".": .clear, "#": .black, "b": .brown, "t": .tan],
        [
            "..##.......##...",
            "...##.....##....",
            "....##...##.....",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
        ]
    )

    private static let headMythic = s(
        [".": .clear, "#": .black, "y": .yellow],
        [
            "....########....",
            "...##yyyyyy##...",
            "....########....",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
        ]
    )

    private static let handCommon = s(
        [".": .clear, "b": .brown],
        [
            "................",
            "................",
            "................",
            "..............b.",
            "..............b.",
            "..............b.",
            "..............b.",
            "..............b.",
            "..............b.",
            "..............b.",
            "..............b.",
            "..............b.",
            "..............b.",
            "................",
            "................",
            "................",
        ]
    )

    private static let handRare = s(
        [".": .clear, "#": .black, "b": .blue],
        [
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "..........#####.",
            "..........#bbb#.",
            "..........#bbb#.",
            "..........#####.",
            "................",
            "................",
            "................",
        ]
    )

    private static let handLegendary = s(
        [".": .clear, "#": .black, "m": .lightGray, "y": .yellow],
        [
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "..........####..",
            "..........#mm#..",
            "..........####..",
            "...........##...",
            "...........#y...",
            "................",
            "................",
            "................",
        ]
    )

    private static let handMythic = s(
        [".": .clear, "#": .black, "g": .green],
        [
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "..........######",
            "..........#gggg#",
            "..........#g.g.#",
            "..........#gggg#",
            "..........#g...#",
            "..........######",
            "................",
            "................",
            "................",
            "................",
        ]
    )

    private static let effectCommon = s(
        [".": .clear, "y": .yellow],
        [
            "y..............y",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "y..............y",
        ]
    )

    private static let effectRare = s(
        [".": .clear, "g": .mint],
        [
            ".g..............",
            "................",
            "................",
            "g...............",
            "................",
            "...............g",
            "................",
            "................",
            ".g..............",
            "................",
            "...............g",
            "................",
            "g...............",
            "................",
            "................",
            "...............g",
        ]
    )

    private static let effectLegendary = s(
        [".": .clear, "r": .red, "y": .yellow, "n": .green, "b": .blue, "p": .purple],
        [
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "rrryyynnnbbbppp.",
            "................",
            "................",
        ]
    )

    private static let effectMythic = s(
        [".": .clear, "y": .yellow, "w": .white],
        [
            ".y..............",
            "...............w",
            "................",
            "....y...........",
            "...............y",
            "................",
            ".w..............",
            "................",
            "...............y",
            "....w...........",
            "................",
            "..............w.",
            ".y..............",
            "................",
            "...............y",
            "......w.........",
        ]
    )

    // MARK: - Menu Bar Icons (8x8)

    public static func menuBarIcon(phase: PetPhase, stage: Stage) -> PixelSprite {
        let palette: [Character: PixelColor] = [
            ".": .clear, "#": .black, "w": .white, "g": .gray,
        ]
        switch phase {
        case .egg:
            return s(palette, [
                "..####..",
                ".#wwww#.",
                "#wwwwww#",
                "#ww##ww#",
                "#wwwwww#",
                "#wwwwww#",
                ".#wwww#.",
                "..####..",
            ])
        case .dead:
            return s(palette, [
                "..####..",
                ".#gggg#.",
                "#g#gg#g#",
                "#gggggg#",
                "#ggg#gg#",
                "#gggggg#",
                ".#gggg#.",
                "..####..",
            ])
        case .alive:
            switch stage {
            case .stage1:
                return s(palette, [
                    "..####..",
                    ".#wwww#.",
                    "#w#ww#w#",
                    "#wwwwww#",
                    "#wwwwww#",
                    ".#wwww#.",
                    "..####..",
                    "........",
                ])
            case .stage2:
                return s(palette, [
                    ".#....#.",
                    ".######.",
                    "#w##w##w",
                    "#wwwwww#",
                    "#wwwwww#",
                    ".#wwww#.",
                    "..####..",
                    "........",
                ])
            case .stage3:
                return s(palette, [
                    "#......#",
                    "########",
                    "#w##w##w",
                    "#wwwwww#",
                    "#wwwwww#",
                    "#wwwwww#",
                    ".######.",
                    "..#..#..",
                ])
            }
        }
    }
}
