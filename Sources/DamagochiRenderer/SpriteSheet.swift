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
        case "owl":        return owlFrames(stage)
        case "cat":        return catFrames(stage)
        case "turtle":     return turtleFrames(stage)
        case "butterfly":  return butterflyFrames(stage)
        case "dragon":     return dragonFrames(stage)
        case "wolf":       return wolfFrames(stage)
        case "octopus":    return octopusFrames(stage)
        case "robot":      return robotFrames(stage)
        case "jellyfish":  return jellyfishFrames(stage)
        case "cloud":      return cloudFrames(stage)
        case "fox":        return foxFrames(stage)
        case "mushroom":   return mushroomFrames(stage)
        case "penguin":    return penguinFrames(stage)
        case "rock":       return rockFrames(stage)
        case "cactus":     return cactusFrames(stage)
        case "parrot":     return parrotFrames(stage)
        case "puppy":      return puppyFrames(stage)
        case "flame":      return flameFrames(stage)
        case "bat":        return batFrames(stage)
        case "moonrabbit": return moonrabbitFrames(stage)
        default:           return defaultFrames(stage)
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

    // MARK: - Wolf

    private static let wolfPalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "g": .gray, "d": .darkGray, "w": .white,
    ]

    private static func wolfFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return wolfStage1
        case .stage2: return wolfStage2
        case .stage3: return wolfStage3
        }
    }

    private static let wolfStage1: [PixelSprite] = [
        s(wolfPalette, [
            "................",
            "................",
            "................",
            "....#......#....",
            "...#g#....#g#...",
            "...#gg####gg#...",
            "..#gggggggggg#..",
            "..#gd##gg##dg#..",
            "..#ggg#ww#ggg#..",
            "..#ggwwwwwwgg#..",
            "...#gggggggg#...",
            "....#gg##gg#....",
            "...##......##...",
            "................",
            "................",
            "................",
        ]),
        s(wolfPalette, [
            "................",
            "................",
            "................",
            "....#......#....",
            "...#g#....#g#...",
            "...#gg####gg#...",
            "..#gggggggggg#..",
            "..#g##gggg##g#..",
            "..#ggg#ww#ggg#..",
            "..#ggwwwwwwgg#..",
            "...#gggggggg#...",
            "....#gg##gg#....",
            "...##......##...",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let wolfStage2: [PixelSprite] = [
        s(wolfPalette, [
            "................",
            "...#........#...",
            "..#g#......#g#..",
            ".#ggg######ggg#.",
            ".#gggggggggggg#.",
            "#gdd##gggg##ddg#",
            "#gggg#wwww#gggg#",
            "#gggwwwwwwwwggg#",
            ".#gggggggggggg#.",
            ".#gggggggggggg#.",
            "..#gggggggggg#..",
            "...#ggg##ggg#...",
            "..##........##..",
            "................",
            "................",
            "................",
        ]),
        s(wolfPalette, [
            "................",
            "...#........#...",
            "..#g#......#g#..",
            ".#ggg######ggg#.",
            ".#gggggggggggg#.",
            "#g####gggg####g#",
            "#gggg#wwww#gggg#",
            "#gggwwwwwwwwggg#",
            ".#gggggggggggg#.",
            ".#gggggggggggg#.",
            "..#gggggggggg#..",
            "...#ggg##ggg#...",
            "..##........##..",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let wolfStage3: [PixelSprite] = [
        s(wolfPalette, [
            "...#........#...",
            "..#g#......#g#..",
            ".#ggg######ggg#.",
            "#gggggggggggggg#",
            "#gdd##gggg##ddg#",
            "#gggg#wwww#gggg#",
            "#gggwwwwwwwwggg#",
            ".#gggggggggggg#.",
            ".#gggggggggggg#.",
            "..#gggggggggg#..",
            "..#gggggggggg#..",
            "...#ggg##ggg#...",
            "..##........##..",
            "................",
            "................",
            "................",
        ]),
        s(wolfPalette, [
            "...#........#...",
            "..#g#......#g#..",
            ".#ggg######ggg#.",
            "#gggggggggggggg#",
            "#g####gggg####g#",
            "#gggg#wwww#gggg#",
            "#gggwwwwwwwwggg#",
            ".#gggggggggggg#.",
            ".#gggggggggggg#.",
            "..#gggggggggg#..",
            "..#gggggggggg#..",
            "...#ggg##ggg#...",
            "..##........##..",
            "................",
            "................",
            "................",
        ]),
    ]

    // MARK: - Octopus

    private static let octopusPalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "p": .purple, "l": .lavender, "w": .white,
    ]

    private static func octopusFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return octopusStage1
        case .stage2: return octopusStage2
        case .stage3: return octopusStage3
        }
    }

    private static let octopusStage1: [PixelSprite] = [
        s(octopusPalette, [
            "................",
            "................",
            "................",
            "......####......",
            ".....#pppp#.....",
            "....#pppppp#....",
            "....#pw##wp#....",
            "....#pppppp#....",
            "....##pppp##....",
            "...#p.#pp#.p#...",
            "...#p.####.p#...",
            "....#.#..#.#....",
            "................",
            "................",
            "................",
            "................",
        ]),
        s(octopusPalette, [
            "................",
            "................",
            "................",
            "......####......",
            ".....#pppp#.....",
            "....#pppppp#....",
            "....#p####p#....",
            "....#pppppp#....",
            "....##pppp##....",
            "...#p.#pp#.p#...",
            "...#p.####.p#...",
            "....#.#..#.#....",
            "................",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let octopusStage2: [PixelSprite] = [
        s(octopusPalette, [
            "................",
            "....########....",
            "...#pppppppp#...",
            "..#pppppppppp#..",
            "..#ppw####wpp#..",
            "..#pppppppppp#..",
            "..#pp####pppp#..",
            "...##pppppp##...",
            "...#p.#pp#.p#...",
            "..#p..####..p#..",
            "..#...#..#...#..",
            "...#..#..#..#...",
            "................",
            "................",
            "................",
            "................",
        ]),
        s(octopusPalette, [
            "................",
            "....########....",
            "...#pppppppp#...",
            "..#pppppppppp#..",
            "..#pp######pp#..",
            "..#pppppppppp#..",
            "..#pp####pppp#..",
            "...##pppppp##...",
            "...#p.#pp#.p#...",
            "..#p..####..p#..",
            "..#...#..#...#..",
            "...#..#..#..#...",
            "................",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let octopusStage3: [PixelSprite] = [
        s(octopusPalette, [
            "....########....",
            "...#pppppppp#...",
            "..#pppppppppp#..",
            ".#pppppppppppp#.",
            ".#pplw####wlpp#.",
            ".#pppppppppppp#.",
            ".#pppp####pppp#.",
            "..##pppppppp##..",
            "..#p.#pppp#.p#..",
            ".#p..#.pp.#..p#.",
            ".#...#....#...#.",
            "..#..#....#..#..",
            "...#.#....#.#...",
            "....##....##....",
            "................",
            "................",
        ]),
        s(octopusPalette, [
            "....########....",
            "...#pppppppp#...",
            "..#pppppppppp#..",
            ".#pppppppppppp#.",
            ".#pp########pp#.",
            ".#pppppppppppp#.",
            ".#pppp####pppp#.",
            "..##pppppppp##..",
            "..#p.#pppp#.p#..",
            ".#p..#.pp.#..p#.",
            ".#...#....#...#.",
            "..#..#....#..#..",
            "...#.#....#.#...",
            "....##....##....",
            "................",
            "................",
        ]),
    ]

    // MARK: - Robot

    private static let robotPalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "m": .lightGray, "b": .blue,
        "r": .red, "y": .yellow, "w": .white,
    ]

    private static func robotFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return robotStage1
        case .stage2: return robotStage2
        case .stage3: return robotStage3
        }
    }

    private static let robotStage1: [PixelSprite] = [
        s(robotPalette, [
            "................",
            "................",
            "................",
            ".......##.......",
            "......#mm#......",
            ".....########...",
            "....#mmmmmmmm#..",
            "....#mb###bm#...",
            "....#mmmmmmmm#..",
            "....#m#y###m#...",
            "....#mmmmmmmm#..",
            ".....########...",
            "....#m#....#m#..",
            "................",
            "................",
            "................",
        ]),
        s(robotPalette, [
            "................",
            "................",
            "................",
            ".......##.......",
            "......#mm#......",
            ".....########...",
            "....#mmmmmmmm#..",
            "....#m#####m#...",
            "....#mmmmmmmm#..",
            "....#m#y###m#...",
            "....#mmmmmmmm#..",
            ".....########...",
            "....#m#....#m#..",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let robotStage2: [PixelSprite] = [
        s(robotPalette, [
            "................",
            "........##......",
            ".......#mm#.....",
            "....##########..",
            "...#mmmmmmmmmm#.",
            "...#mb####bmmm#.",
            "...#mmmmmmmmmm#.",
            "...#mm#yyy#mmm#.",
            "...#mmmmmmmmmm#.",
            "....##########..",
            "..#m#........#m#",
            "..#mm#......#mm#",
            "...#m#......#m#.",
            "................",
            "................",
            "................",
        ]),
        s(robotPalette, [
            "................",
            "........##......",
            ".......#mm#.....",
            "....##########..",
            "...#mmmmmmmmmm#.",
            "...#m########m#.",
            "...#mmmmmmmmmm#.",
            "...#mm#yyy#mmm#.",
            "...#mmmmmmmmmm#.",
            "....##########..",
            "..#m#........#m#",
            "..#mm#......#mm#",
            "...#m#......#m#.",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let robotStage3: [PixelSprite] = [
        s(robotPalette, [
            "........##......",
            ".......#mm#.....",
            "...############.",
            "..#mmmmmmmmmmmm#",
            "..#mb####r#bmmm#",
            "..#mmmmmmmmmmmm#",
            "..#mmm#yyy#mmmm#",
            "..#mmmmmmmmmmmm#",
            "...############.",
            ".#m#..........#m",
            ".#mm#........#mm",
            ".#mmm#......#mmm",
            "..#m#........#m.",
            "................",
            "................",
            "................",
        ]),
        s(robotPalette, [
            "........##......",
            ".......#mm#.....",
            "...############.",
            "..#mmmmmmmmmmmm#",
            "..#m##########m#",
            "..#mmmmmmmmmmmm#",
            "..#mmm#yyy#mmmm#",
            "..#mmmmmmmmmmmm#",
            "...############.",
            ".#m#..........#m",
            ".#mm#........#mm",
            ".#mmm#......#mmm",
            "..#m#........#m.",
            "................",
            "................",
            "................",
        ]),
    ]

    // MARK: - Jellyfish

    private static let jellyfishPalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "b": .blue, "l": .lavender,
        "p": .pink, "w": .white,
    ]

    private static func jellyfishFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return jellyfishStage1
        case .stage2: return jellyfishStage2
        case .stage3: return jellyfishStage3
        }
    }

    private static let jellyfishStage1: [PixelSprite] = [
        s(jellyfishPalette, [
            "................",
            "................",
            "................",
            "......####......",
            "....##llll##....",
            "...#llllllll#...",
            "...#lw##llll#...",
            "...#llllllll#...",
            "...#llllllll#...",
            "....########....",
            "....#l.ll.l#....",
            "....#......#....",
            "....#l.ll.l#....",
            "................",
            "................",
            "................",
        ]),
        s(jellyfishPalette, [
            "................",
            "................",
            "................",
            "......####......",
            "....##llll##....",
            "...#llllllll#...",
            "...#l####lll#...",
            "...#llllllll#...",
            "...#llllllll#...",
            "....########....",
            "....#..ll..#....",
            "....#l.ll.l#....",
            "....#......#....",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let jellyfishStage2: [PixelSprite] = [
        s(jellyfishPalette, [
            "................",
            ".....########...",
            "...##llllllll##.",
            "..#llllllllllll#",
            "..#llw####wllll#",
            "..#llllllllllll#",
            "..#lllllllllll#.",
            "...#llllllllll#.",
            "....##########..",
            "....#l.llll.l#..",
            "....#ll....ll#..",
            "....#l.llll.l#..",
            "....#ll....ll#..",
            "................",
            "................",
            "................",
        ]),
        s(jellyfishPalette, [
            "................",
            ".....########...",
            "...##llllllll##.",
            "..#llllllllllll#",
            "..#ll########ll#",
            "..#llllllllllll#",
            "..#lllllllllll#.",
            "...#llllllllll#.",
            "....##########..",
            "....#..llll..#..",
            "....#l.llll.l#..",
            "....#ll....ll#..",
            "....#l.llll.l#..",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let jellyfishStage3: [PixelSprite] = [
        s(jellyfishPalette, [
            "....##########..",
            "..##llllllllll##",
            ".#llllllllllllll",
            "#lllllllllllllll",
            "#llllw####wlllll",
            "#lllllllllllllll",
            "#llllllllllllll#",
            ".#lllllllllllll#",
            "..##############",
            "...#ll.llll.ll#.",
            "...#lll....lll#.",
            "...#ll.llll.ll#.",
            "...#lll....lll#.",
            "....###....###..",
            "................",
            "................",
        ]),
        s(jellyfishPalette, [
            "....##########..",
            "..##llllllllll##",
            ".#llllllllllllll",
            "#lllllllllllllll",
            "#llll########lll",
            "#lllllllllllllll",
            "#llllllllllllll#",
            ".#lllllllllllll#",
            "..##############",
            "...#...llll...#.",
            "...#ll.llll.ll#.",
            "...#lll....lll#.",
            "...#ll.llll.ll#.",
            "....###....###..",
            "................",
            "................",
        ]),
    ]

    // MARK: - Cloud

    private static let cloudPalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "w": .white, "l": .lightGray, "b": .blue,
    ]

    private static func cloudFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return cloudStage1
        case .stage2: return cloudStage2
        case .stage3: return cloudStage3
        }
    }

    private static let cloudStage1: [PixelSprite] = [
        s(cloudPalette, [
            "................",
            "................",
            "................",
            "....####........",
            "...#wwww#####...",
            "..#wwwwwwwwww#..",
            "..#ww##wwwwww#..",
            "..#wwwwwwwwww#..",
            "..#wwb.b.wwww#..",
            "..#wwwwwwwwww#..",
            "...####wwww###..",
            "....#llllll#....",
            "................",
            "................",
            "................",
            "................",
        ]),
        s(cloudPalette, [
            "................",
            "................",
            "................",
            "....####........",
            "...#wwww#####...",
            "..#wwwwwwwwww#..",
            "..#w####wwwww#..",
            "..#wwwwwwwwww#..",
            "..#wwb.b.wwww#..",
            "..#wwwwwwwwww#..",
            "...####wwww###..",
            "....#llllll#....",
            "................",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let cloudStage2: [PixelSprite] = [
        s(cloudPalette, [
            "................",
            "...####.........",
            "..#wwww######...",
            ".#wwwwwwwwwwww#.",
            ".#wwwwwwwwwwww#.",
            "#wwww##ww##wwww#",
            "#wwwwwwwwwwwwww#",
            "#wwwb..b..bwwww#",
            "#wwwwwwwwwwwwww#",
            ".#wwww####wwww#.",
            ".#wwwwwwwwwwww#.",
            "..####wwwwww###.",
            "...#llllllll#...",
            "................",
            "................",
            "................",
        ]),
        s(cloudPalette, [
            "................",
            "...####.........",
            "..#wwww######...",
            ".#wwwwwwwwwwww#.",
            ".#wwwwwwwwwwww#.",
            "#w####ww######w#",
            "#wwwwwwwwwwwwww#",
            "#wwwb..b..bwwww#",
            "#wwwwwwwwwwwwww#",
            ".#wwww####wwww#.",
            ".#wwwwwwwwwwww#.",
            "..####wwwwww###.",
            "...#llllllll#...",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let cloudStage3: [PixelSprite] = [
        s(cloudPalette, [
            "..####..........",
            ".#wwww#######...",
            "#wwwwwwwwwwwww#.",
            "#wwwwwwwwwwwwww#",
            "#wwww##ww##wwww#",
            "#wwwwwwwwwwwwww#",
            "#wwwb..b..bwwww#",
            "#wwwwwwwwwwwwww#",
            ".#wwwwwwwwwwww#.",
            ".#wwwwwwwwwwww#.",
            "..####wwwwww###.",
            "...#llllllllll#.",
            "....##########..",
            "................",
            "................",
            "................",
        ]),
        s(cloudPalette, [
            "..####..........",
            ".#wwww#######...",
            "#wwwwwwwwwwwww#.",
            "#wwwwwwwwwwwwww#",
            "#w####ww######w#",
            "#wwwwwwwwwwwwww#",
            "#wwwb..b..bwwww#",
            "#wwwwwwwwwwwwww#",
            ".#wwwwwwwwwwww#.",
            ".#wwwwwwwwwwww#.",
            "..####wwwwww###.",
            "...#llllllllll#.",
            "....##########..",
            "................",
            "................",
            "................",
        ]),
    ]

    // MARK: - Fox

    private static let foxPalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "o": .ginger, "w": .white,
        "b": .brown, "p": .pink,
    ]

    private static func foxFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return foxStage1
        case .stage2: return foxStage2
        case .stage3: return foxStage3
        }
    }

    private static let foxStage1: [PixelSprite] = [
        s(foxPalette, [
            "................",
            "................",
            "................",
            "....#......#....",
            "...#o#....#o#...",
            "...#oo####oo#...",
            "..#oooooooooo#..",
            "..#ob##oo##bo#..",
            "..#ooo#pp#ooo#..",
            "..#oowwwwwwoo#..",
            "...#oooooooo#...",
            "....#oo##oo#....",
            "...##..ww..##...",
            "................",
            "................",
            "................",
        ]),
        s(foxPalette, [
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
            "...##..ww..##...",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let foxStage2: [PixelSprite] = [
        s(foxPalette, [
            "................",
            "...#........#...",
            "..#o#......#o#..",
            ".#ooo######ooo#.",
            ".#oooooooooooo#.",
            "#obb##oooo##bbo#",
            "#oooo#wwww#oooo#",
            "#ooowwwwwwwwoooo",
            ".#oooooooooooo#.",
            ".#oowwwwwwwwoo#.",
            "..#owwwwwwwwo#..",
            "..#oooooooooo#..",
            "...#ooo##ooo#...",
            "..##...ww...##..",
            "................",
            "................",
        ]),
        s(foxPalette, [
            "................",
            "...#........#...",
            "..#o#......#o#..",
            ".#ooo######ooo#.",
            ".#oooooooooooo#.",
            "#o####oooo####o#",
            "#oooo#wwww#oooo#",
            "#ooowwwwwwwwoooo",
            ".#oooooooooooo#.",
            ".#oowwwwwwwwoo#.",
            "..#owwwwwwwwo#..",
            "..#oooooooooo#..",
            "...#ooo##ooo#...",
            "..##...ww...##..",
            "................",
            "................",
        ]),
    ]

    private static let foxStage3: [PixelSprite] = [
        s(foxPalette, [
            "...#........#...",
            "..#o#......#o#..",
            ".#ooo######ooo#.",
            "#oooooooooooooo#",
            "#obb##oooo##bbo#",
            "#oooo#wwww#oooo#",
            "#ooowwwwwwwwoooo",
            ".#oooooooooooo#.",
            ".#oowwwwwwwwoo#.",
            "..#owwwwwwwwo#..",
            "..#oooooooooo#..",
            "..#oooooooooo#..",
            "...#ooo##ooo#...",
            "..##...ww...##..",
            "................",
            "................",
        ]),
        s(foxPalette, [
            "...#........#...",
            "..#o#......#o#..",
            ".#ooo######ooo#.",
            "#oooooooooooooo#",
            "#o####oooo####o#",
            "#oooo#wwww#oooo#",
            "#ooowwwwwwwwoooo",
            ".#oooooooooooo#.",
            ".#oowwwwwwwwoo#.",
            "..#owwwwwwwwo#..",
            "..#oooooooooo#..",
            "..#oooooooooo#..",
            "...#ooo##ooo#...",
            "..##...ww...##..",
            "................",
            "................",
        ]),
    ]

    // MARK: - Mushroom

    private static let mushroomPalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "r": .red, "w": .white, "t": .tan,
    ]

    private static func mushroomFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return mushroomStage1
        case .stage2: return mushroomStage2
        case .stage3: return mushroomStage3
        }
    }

    private static let mushroomStage1: [PixelSprite] = [
        s(mushroomPalette, [
            "................",
            "................",
            "................",
            ".....######.....",
            "....#rrrrrr#....",
            "...#rrrwwrrr#...",
            "...#rrrrrrrr#...",
            "..#rrrwwwwrrr#..",
            "..#rrrrrrrrrr#..",
            "...#rr#ww#rr#...",
            "....#wwwwww#....",
            "....#w####w#....",
            ".....######.....",
            "................",
            "................",
            "................",
        ]),
        s(mushroomPalette, [
            "................",
            "................",
            "................",
            ".....######.....",
            "....#rrrrrr#....",
            "...#rrrwwrrr#...",
            "...#rrrrrrrr#...",
            "..#rrrwwwwrrr#..",
            "..#rrrrrrrrrr#..",
            "...#r##ww##r#...",
            "....#wwwwww#....",
            "....#w####w#....",
            ".....######.....",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let mushroomStage2: [PixelSprite] = [
        s(mushroomPalette, [
            "................",
            "....########....",
            "...#rrrrrrrr#...",
            "..#rrrwwwwrrrr#.",
            "..#rrrrrrrrrrr#.",
            ".#rrrwwwwwwrrr#.",
            ".#rrrrrrrrrrrr#.",
            "..#rr#wwww#rr#..",
            "...#wwwwwwwww#..",
            "...#ww######w#..",
            "...#wwwwwwwww#..",
            "....#w######w#..",
            ".....########...",
            "................",
            "................",
            "................",
        ]),
        s(mushroomPalette, [
            "................",
            "....########....",
            "...#rrrrrrrr#...",
            "..#rrrwwwwrrrr#.",
            "..#rrrrrrrrrrr#.",
            ".#rrrwwwwwwrrr#.",
            ".#rrrrrrrrrrrr#.",
            "..#r###wwww##r#.",
            "...#wwwwwwwww#..",
            "...#ww######w#..",
            "...#wwwwwwwww#..",
            "....#w######w#..",
            ".....########...",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let mushroomStage3: [PixelSprite] = [
        s(mushroomPalette, [
            "...##########...",
            "..#rrrrrrrrrr#..",
            ".#rrrrwwwwrrrr#.",
            "#rrrrrrrrrrrrrr#",
            "#rrrwwwwwwwwrrr#",
            "#rrrrrrrrrrrrrr#",
            ".#rr#wwwwww#rr#.",
            "..#wwwwwwwwwww#.",
            "..#ww##wwww##w#.",
            "..#wwwwwwwwwww#.",
            "..#ww########w#.",
            "..#wwwwwwwwwww#.",
            "...#w##wwww##w#.",
            "....###wwww###..",
            "................",
            "................",
        ]),
        s(mushroomPalette, [
            "...##########...",
            "..#rrrrrrrrrr#..",
            ".#rrrrwwwwrrrr#.",
            "#rrrrrrrrrrrrrr#",
            "#rrr########rrr#",
            "#rrrrrrrrrrrrrr#",
            ".#r####wwww####.",
            "..#wwwwwwwwwww#.",
            "..#ww##wwww##w#.",
            "..#wwwwwwwwwww#.",
            "..#ww########w#.",
            "..#wwwwwwwwwww#.",
            "...#w##wwww##w#.",
            "....###wwww###..",
            "................",
            "................",
        ]),
    ]

    // MARK: - Penguin

    private static let penguinPalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "w": .white, "o": .orange, "b": .blue,
    ]

    private static func penguinFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return penguinStage1
        case .stage2: return penguinStage2
        case .stage3: return penguinStage3
        }
    }

    private static let penguinStage1: [PixelSprite] = [
        s(penguinPalette, [
            "................",
            "................",
            "................",
            "......####......",
            ".....#####......",
            "....########....",
            "...##ww##ww##...",
            "...#wwwwwwww#...",
            "...#w##oo##w#...",
            "...#wwwwwwww#...",
            "....########....",
            "....#o#..#o#....",
            "...##........##.",
            "................",
            "................",
            "................",
        ]),
        s(penguinPalette, [
            "................",
            "................",
            "................",
            "......####......",
            ".....#####......",
            "....########....",
            "...##ww##ww##...",
            "...#wwwwwwww#...",
            "...#w####w##w...",
            "...#wwwwwwww#...",
            "....########....",
            "....#o#..#o#....",
            "...##........##.",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let penguinStage2: [PixelSprite] = [
        s(penguinPalette, [
            "................",
            ".....######.....",
            "....########....",
            "...##########...",
            "..##ww####ww##..",
            "..#wwwwwwwwww#..",
            "..#ww##oo##ww#..",
            "..#wwwwwwwwww#..",
            "..#wwwwwwwwww#..",
            "...##########...",
            "...#oo#..#oo#...",
            "..##..........##",
            "................",
            "................",
            "................",
            "................",
        ]),
        s(penguinPalette, [
            "................",
            ".....######.....",
            "....########....",
            "...##########...",
            "..##ww####ww##..",
            "..#wwwwwwwwww#..",
            "..#w########w...",
            "..#wwwwwwwwww#..",
            "..#wwwwwwwwww#..",
            "...##########...",
            "...#oo#..#oo#...",
            "..##..........##",
            "................",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let penguinStage3: [PixelSprite] = [
        s(penguinPalette, [
            "......######....",
            ".....########...",
            "....##########..",
            "..###ww####ww###",
            "..#wwwwwwwwwwww#",
            "..#ww##oooo##ww#",
            "..#wwwwwwwwwwww#",
            "..#wwwwwwwwwwww#",
            "..#wwwwwwwwwwww#",
            "...############.",
            "...#ooo#..#ooo#.",
            "..##............",
            "................",
            "................",
            "................",
            "................",
        ]),
        s(penguinPalette, [
            "......######....",
            ".....########...",
            "....##########..",
            "..###ww####ww###",
            "..#wwwwwwwwwwww#",
            "..#w############",
            "..#wwwwwwwwwwww#",
            "..#wwwwwwwwwwww#",
            "..#wwwwwwwwwwww#",
            "...############.",
            "...#ooo#..#ooo#.",
            "..##............",
            "................",
            "................",
            "................",
            "................",
        ]),
    ]

    // MARK: - Rock

    private static let rockPalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "g": .gray, "l": .lightGray, "d": .darkGray,
    ]

    private static func rockFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return rockStage1
        case .stage2: return rockStage2
        case .stage3: return rockStage3
        }
    }

    private static let rockStage1: [PixelSprite] = [
        s(rockPalette, [
            "................",
            "................",
            "................",
            "................",
            "......####......",
            "....##gggg##....",
            "...#gglggggg#...",
            "...#gggggggg#...",
            "...#ggg##ggg#...",
            "...#gggggggg#...",
            "....########....",
            "................",
            "................",
            "................",
            "................",
            "................",
        ]),
        s(rockPalette, [
            "................",
            "................",
            "................",
            "................",
            "......####......",
            "....##gggg##....",
            "...#gglggggg#...",
            "...#gggggggg#...",
            "...#g##g##gg#...",
            "...#gggggggg#...",
            "....########....",
            "................",
            "................",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let rockStage2: [PixelSprite] = [
        s(rockPalette, [
            "................",
            "................",
            ".....########...",
            "...##gggggggg##.",
            "..#gglggggggggg#",
            "..#ggggggggggg#.",
            "..#ggggg##gggg#.",
            "..#gggggggggg#..",
            "..#ggggggggggg#.",
            "..#gggggggggg#..",
            "...############.",
            "................",
            "................",
            "................",
            "................",
            "................",
        ]),
        s(rockPalette, [
            "................",
            "................",
            ".....########...",
            "...##gggggggg##.",
            "..#gglggggggggg#",
            "..#ggggggggggg#.",
            "..#gg###g###gg#.",
            "..#gggggggggg#..",
            "..#ggggggggggg#.",
            "..#gggggggggg#..",
            "...############.",
            "................",
            "................",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let rockStage3: [PixelSprite] = [
        s(rockPalette, [
            "................",
            "....##########..",
            "..##gggggggggg##",
            ".#gglgggggggggg#",
            ".#ggggggggggggd#",
            "#ggggggggggggggg",
            "#gggggg##ggggggg",
            "#ggggggggggggggg",
            "#ggggggggggggggg",
            ".#ggggggggggggg#",
            "..#############.",
            "................",
            "................",
            "................",
            "................",
            "................",
        ]),
        s(rockPalette, [
            "................",
            "....##########..",
            "..##gggggggggg##",
            ".#gglgggggggggg#",
            ".#ggggggggggggd#",
            "#ggggggggggggggg",
            "#ggg####g####ggg",
            "#ggggggggggggggg",
            "#ggggggggggggggg",
            ".#ggggggggggggg#",
            "..#############.",
            "................",
            "................",
            "................",
            "................",
            "................",
        ]),
    ]

    // MARK: - Cactus

    private static let cactusPalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "g": .green, "d": .darkGreen, "y": .yellow,
    ]

    private static func cactusFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return cactusStage1
        case .stage2: return cactusStage2
        case .stage3: return cactusStage3
        }
    }

    private static let cactusStage1: [PixelSprite] = [
        s(cactusPalette, [
            "................",
            "................",
            "................",
            "......####......",
            ".....#gggg#.....",
            "....#gggggg#....",
            "#...#gg##gg#....",
            "##..#gggggg#....",
            ".#..#gggggg#....",
            ".###########....",
            "....#gggggg#....",
            "....#gg##gg#....",
            "....#g####g#....",
            "....########....",
            "................",
            "................",
        ]),
        s(cactusPalette, [
            "................",
            "................",
            "................",
            "......####......",
            ".....#gggg#.....",
            "....#gggggg#....",
            "....#gg##gg#...#",
            "....#gggggg#..##",
            "....#gggggg#..#.",
            "....###########.",
            "....#gggggg#....",
            "....#gg##gg#....",
            "....#g####g#....",
            "....########....",
            "................",
            "................",
        ]),
    ]

    private static let cactusStage2: [PixelSprite] = [
        s(cactusPalette, [
            "................",
            ".......#####....",
            "......#ggggg#...",
            "##...#ggggggg#..",
            "##...#gg###gg#..",
            ".####ggggggggg#.",
            "....#ggggggggg#.",
            "....#gg#####gg#.",
            "....#ggggggggg#.",
            "....#ggggggggg#.",
            "....#ggggggggg#.",
            "....#gg#####gg#.",
            "....#g#######g#.",
            ".....#########..",
            "................",
            "................",
        ]),
        s(cactusPalette, [
            "................",
            ".......#####....",
            "......#ggggg#...",
            "......#gg###gg#.",
            ".....#ggggggggg#",
            ".....#gggg##ggg#",
            ".....#ggggggggg#",
            "..##.#gg#####gg#",
            "..##.#ggggggggg#",
            "..###ggggggggg#.",
            "....#ggggggggg#.",
            "....#gg#####gg#.",
            "....#g#######g#.",
            ".....#########..",
            "................",
            "................",
        ]),
    ]

    private static let cactusStage3: [PixelSprite] = [
        s(cactusPalette, [
            "........#####...",
            ".......#ggggg#..",
            "###...#ggggggg#.",
            "###..#ggg###ggg#",
            ".####ggggggggggg",
            "....#ggggggggggg",
            "....#ggggg#ggggg",
            "....#ggggggggggg",
            "....#gg#######gg",
            "....#ggggggggggg",
            "....#ggggggggggg",
            "....#gg#######gg",
            "....#g#########g",
            ".....###########",
            "................",
            "................",
        ]),
        s(cactusPalette, [
            "........#####...",
            ".......#ggggg#..",
            "......#ggggggg#.",
            "......#ggg###ggg",
            ".....#gggggggggg",
            "####.#ggggggggg#",
            "####.#ggggg#gggg",
            ".#####ggggggggg#",
            "....#gg#######gg",
            "....#ggggggggggg",
            "....#ggggggggggg",
            "....#gg#######gg",
            "....#g#########g",
            ".....###########",
            "................",
            "................",
        ]),
    ]

    // MARK: - Parrot

    private static let parrotPalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "g": .green, "r": .red,
        "y": .yellow, "w": .white, "b": .blue,
    ]

    private static func parrotFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return parrotStage1
        case .stage2: return parrotStage2
        case .stage3: return parrotStage3
        }
    }

    private static let parrotStage1: [PixelSprite] = [
        s(parrotPalette, [
            "................",
            "................",
            "................",
            ".....#######....",
            "....#rrrrrrr#...",
            "...#gggrrrrr##..",
            "...#ggggggggg#..",
            "...#gw##gg##wg#.",
            "...#ggg#yy#ggg#.",
            "...#ggggggggg#..",
            "....#########...",
            "....#gg...gg#...",
            "....#g#...#g#...",
            "................",
            "................",
            "................",
        ]),
        s(parrotPalette, [
            "................",
            "................",
            "................",
            ".....#######....",
            "....#rrrrrrr#...",
            "...#gggrrrrr##..",
            "...#ggggggggg#..",
            "...#g##ggg##g#..",
            "...#ggg#yy#ggg#.",
            "...#ggggggggg#..",
            "....#########...",
            "....#gg...gg#...",
            "....#g#...#g#...",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let parrotStage2: [PixelSprite] = [
        s(parrotPalette, [
            "................",
            "....#########...",
            "...#rrrrrrrrr#..",
            "..#gggrrrrrrr##.",
            "..#gggggggggggg#",
            "..#gw####gggggg#",
            "..#gggggggggggg#",
            "..#ggg#yyyg#ggg#",
            "..#gggggggggggg#",
            "...#############",
            "....#ggg...ggg#.",
            "....#gg.....gg#.",
            "....#g#.....#g#.",
            "................",
            "................",
            "................",
        ]),
        s(parrotPalette, [
            "................",
            "....#########...",
            "...#rrrrrrrrr#..",
            "..#gggrrrrrrr##.",
            "..#gggggggggggg#",
            "..#g##########g#",
            "..#gggggggggggg#",
            "..#ggg#yyyg#ggg#",
            "..#gggggggggggg#",
            "...#############",
            "....#ggg...ggg#.",
            "....#gg.....gg#.",
            "....#g#.....#g#.",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let parrotStage3: [PixelSprite] = [
        s(parrotPalette, [
            "...#############",
            "..#rrrrrrrrrrrrr",
            ".#gggrrrrrrrrrrr",
            "#ggggggggggggggg",
            "#gw####ggggggggr",
            "#gggggggggggggg#",
            "#ggggg#yyy#ggggg",
            "#gggggggggggggg#",
            "#gggggggggggggg#",
            ".##############.",
            "...#ggggg#ggggg.",
            "...#gggg...gggg.",
            "...#ggg.....ggg.",
            "...#g#.......#g.",
            "................",
            "................",
        ]),
        s(parrotPalette, [
            "...#############",
            "..#rrrrrrrrrrrrr",
            ".#gggrrrrrrrrrrr",
            "#ggggggggggggggg",
            "#g#############r",
            "#gggggggggggggg#",
            "#ggggg#yyy#ggggg",
            "#gggggggggggggg#",
            "#gggggggggggggg#",
            ".##############.",
            "...#ggggg#ggggg.",
            "...#gggg...gggg.",
            "...#ggg.....ggg.",
            "...#g#.......#g.",
            "................",
            "................",
        ]),
    ]

    // MARK: - Puppy

    private static let puppyPalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "t": .tan, "w": .white,
        "b": .brown, "p": .pink,
    ]

    private static func puppyFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return puppyStage1
        case .stage2: return puppyStage2
        case .stage3: return puppyStage3
        }
    }

    private static let puppyStage1: [PixelSprite] = [
        s(puppyPalette, [
            "................",
            "................",
            "................",
            "...##......##...",
            "..#tt#....#tt#..",
            "..#tttt##tttt#..",
            "..#tttttttttt#..",
            "..#tb##tt##bt#..",
            "..#ttt#pp#ttt#..",
            "..#ttwwwwwwtt#..",
            "...#tttttttt#...",
            "....#tt##tt#....",
            "...##......##...",
            "................",
            "................",
            "................",
        ]),
        s(puppyPalette, [
            "................",
            "................",
            "................",
            "...##......##...",
            "..#tt#....#tt#..",
            "..#tttt##tttt#..",
            "..#tttttttttt#..",
            "..#t##tttt##t#..",
            "..#ttt#pp#ttt#..",
            "..#ttwwwwwwtt#..",
            "...#tttttttt#...",
            "....#tt##tt#....",
            "...##......##...",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let puppyStage2: [PixelSprite] = [
        s(puppyPalette, [
            "................",
            "..##........##..",
            ".#tt#......#tt#.",
            ".#tttttt##tttttt",
            ".#tttttttttttt#.",
            "#tbb##tttttt##bb",
            "#ttttt#wwww#tttt",
            "#ttttwwwwwwwwttt",
            ".#tttttttttttt#.",
            ".#ttttttttttt#..",
            "..#tttttttttt#..",
            "...#ttt##ttt#...",
            "..##........##..",
            "................",
            "................",
            "................",
        ]),
        s(puppyPalette, [
            "................",
            "..##........##..",
            ".#tt#......#tt#.",
            ".#tttttt##tttttt",
            ".#tttttttttttt#.",
            "#t####tttttt####",
            "#ttttt#wwww#tttt",
            "#ttttwwwwwwwwttt",
            ".#tttttttttttt#.",
            ".#ttttttttttt#..",
            "..#tttttttttt#..",
            "...#ttt##ttt#...",
            "..##........##..",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let puppyStage3: [PixelSprite] = [
        s(puppyPalette, [
            "..##........##..",
            ".#tt#......#tt#.",
            ".#ttttttttttttt#",
            "#tttttttttttttt#",
            "#tbb##tttttt##bt",
            "#ttttt#wwww#tttt",
            "#ttttwwwwwwwwttt",
            ".#tttttttttttt#.",
            ".#tttttttttttt#.",
            "..#tttttttttt#..",
            "..#tttttttttt#..",
            "...#ttt##ttt#...",
            "..##........##..",
            "................",
            "................",
            "................",
        ]),
        s(puppyPalette, [
            "..##........##..",
            ".#tt#......#tt#.",
            ".#ttttttttttttt#",
            "#tttttttttttttt#",
            "#t####tttttt####",
            "#ttttt#wwww#tttt",
            "#ttttwwwwwwwwttt",
            ".#tttttttttttt#.",
            ".#tttttttttttt#.",
            "..#tttttttttt#..",
            "..#tttttttttt#..",
            "...#ttt##ttt#...",
            "..##........##..",
            "................",
            "................",
            "................",
        ]),
    ]

    // MARK: - Flame

    private static let flamePalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "r": .red, "o": .orange, "y": .yellow, "w": .white,
    ]

    private static func flameFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return flameStage1
        case .stage2: return flameStage2
        case .stage3: return flameStage3
        }
    }

    private static let flameStage1: [PixelSprite] = [
        s(flamePalette, [
            "................",
            "................",
            "......###.......",
            ".....#ooo#......",
            "....#ooooo#.....",
            "...#ooyyyyy#....",
            "..#ooyyyyyy#....",
            "..#ooyywyyyy#...",
            "..#oooyyyyy#....",
            "..#roooooor#....",
            "..#rroooorr#....",
            "...#rrrrrr#.....",
            "....######......",
            "................",
            "................",
            "................",
        ]),
        s(flamePalette, [
            "................",
            ".......###......",
            "......#ooo#.....",
            ".....#ooooo#....",
            "....#ooyyyyy#...",
            "...#ooyyyyyy#...",
            "...#ooyywyyy#...",
            "..#roooooooo#...",
            "..#rroooooor#...",
            "..#rrrooorrr#...",
            "...#rrrrrr#.....",
            "....######......",
            "................",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let flameStage2: [PixelSprite] = [
        s(flamePalette, [
            "................",
            ".....####.......",
            "....#oooo#......",
            "...#ooooooo#....",
            "..#ooyyyyyyy#...",
            "..#ooyyyyyyyy#..",
            "..#ooyywyyyy##..",
            ".#oooyyyyyyy#...",
            ".#ooooyyyyyyy#..",
            ".#roooooooooo#..",
            ".#rroooooooor#..",
            ".#rrrooooorrr#..",
            "..#rrrrrrrrr#...",
            "...#########....",
            "................",
            "................",
        ]),
        s(flamePalette, [
            "................",
            "......####......",
            ".....#oooo#.....",
            "....#ooooooo#...",
            "...#ooyyyyyyy#..",
            "..#ooyyyyyyy##..",
            "..#ooyywyyyyy#..",
            "..#oooyyyyyyy#..",
            ".#roooooooooo#..",
            ".#rroooooooor#..",
            ".#rrrooooorrr#..",
            "..#rrrrrrrrr#...",
            "...#########....",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let flameStage3: [PixelSprite] = [
        s(flamePalette, [
            "....####........",
            "...#oooo#.......",
            "..#oooooooo#....",
            ".#oooyyyyyyy#...",
            ".#ooyyyyyyyy##..",
            "#ooyyyyywyyy#...",
            "#oooyyyyyyy#....",
            "#oooyyyyyyyy#...",
            "#rooooooooooo#..",
            "#rroooooooooor#.",
            ".#rrrooooorrr#..",
            ".#rrrrrrrrrr#...",
            "..#rrrrrrrr#....",
            "...##########...",
            "................",
            "................",
        ]),
        s(flamePalette, [
            ".....####.......",
            "....#oooo#......",
            "...#oooooooo#...",
            "..#oooyyyyyyy#..",
            ".#ooyyyyyyyy##..",
            ".#oyyyyywyyy#...",
            "#oooyyyyyyyy#...",
            "#rooooooooooo#..",
            "#rroooooooooor#.",
            "#rrrooooooorrr#.",
            ".#rrrrrrrrrrr#..",
            "..#rrrrrrrrrr#..",
            "...##########...",
            "................",
            "................",
            "................",
        ]),
    ]

    // MARK: - Bat

    private static let batPalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "d": .darkGray, "p": .purple,
        "w": .white, "r": .red,
    ]

    private static func batFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return batStage1
        case .stage2: return batStage2
        case .stage3: return batStage3
        }
    }

    private static let batStage1: [PixelSprite] = [
        s(batPalette, [
            "................",
            "................",
            "................",
            "#.....####.....#",
            "##...#dddd#...##",
            ".#...#dddd#...#.",
            ".##.#dddddd#.##.",
            "..##dpddddpd##..",
            "...#dddddddd#...",
            "...#dd#rr#dd#...",
            "...#dddddddd#...",
            "....#dddddd#....",
            ".....######.....",
            "................",
            "................",
            "................",
        ]),
        s(batPalette, [
            "................",
            "................",
            "#.....####.....#",
            "##...#dddd#...##",
            ".##.#dddddd#.##.",
            "..##dpddddpd##..",
            "...#dddddddd#...",
            "...#dd#rr#dd#...",
            "...#dddddddd#...",
            "....#dddddd#....",
            ".....######.....",
            "................",
            "................",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let batStage2: [PixelSprite] = [
        s(batPalette, [
            "................",
            "#......####....#",
            "##....#dddd#..##",
            ".##..#dddddd#.##",
            "..##.#dddddd#.##",
            "...##dpddddpd##.",
            "...#dddddddddd#.",
            "...#ddd#rr#ddd#.",
            "...#dddddddddd#.",
            "...#dddddddddd#.",
            "....#dddddddd#..",
            "....##dddddd##..",
            ".....########...",
            "................",
            "................",
            "................",
        ]),
        s(batPalette, [
            "#......####....#",
            "##....#dddd#..##",
            ".##..#dddddd#.##",
            "..###dddddddd##.",
            "...##dpddddpd##.",
            "...#dddddddddd#.",
            "...#ddd#rr#ddd#.",
            "...#dddddddddd#.",
            "...#dddddddddd#.",
            "....#dddddddd#..",
            "....##dddddd##..",
            ".....########...",
            "................",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let batStage3: [PixelSprite] = [
        s(batPalette, [
            "#.....######...#",
            "##...#dddddd#.##",
            ".##.#dddddddd###",
            "..##ddddddddddd#",
            "...#dpdddddddpd#",
            "...#dddddddddd#.",
            "...#ddd#rr#ddd#.",
            "...#dddddddddd#.",
            "...#dddddddddd#.",
            "....#dddddddd#..",
            "....#dddddddd#..",
            "....##dddddd##..",
            ".....########...",
            "................",
            "................",
            "................",
        ]),
        s(batPalette, [
            "#.....######...#",
            "##...#dddddd#.##",
            ".##.#dddddddd###",
            "..###ddddddddddd",
            "...#dpdddddddpd#",
            "...#dddddddddd#.",
            "...#d###rr###d#.",
            "...#dddddddddd#.",
            "...#dddddddddd#.",
            "....#dddddddd#..",
            "....#dddddddd#..",
            "....##dddddd##..",
            ".....########...",
            "................",
            "................",
            "................",
        ]),
    ]

    // MARK: - Moon Rabbit

    private static let moonrabbitPalette: [Character: PixelColor] = [
        ".": .clear, "#": .black, "w": .white, "l": .lightGray,
        "y": .yellow, "p": .pink, "g": .gold,
    ]

    private static func moonrabbitFrames(_ stage: Stage) -> [PixelSprite] {
        switch stage {
        case .stage1: return moonrabbitStage1
        case .stage2: return moonrabbitStage2
        case .stage3: return moonrabbitStage3
        }
    }

    private static let moonrabbitStage1: [PixelSprite] = [
        s(moonrabbitPalette, [
            "................",
            "....#......#....",
            "....#w....w#....",
            "....#w....w#....",
            "....#w....w#....",
            "...#wwwwwwww#...",
            "...#wl##wwlw#...",
            "...#wwwwwwww#...",
            "...#ww#pp#ww#...",
            "...#wwwwwwww#...",
            "....########....",
            ".....#w..w#.....",
            "......####......",
            "................",
            "................",
            "................",
        ]),
        s(moonrabbitPalette, [
            "................",
            "....#......#....",
            "....#w....w#....",
            "....#w....w#....",
            "....#w....w#....",
            "...#wwwwwwww#...",
            "...#w####www#...",
            "...#wwwwwwww#...",
            "...#ww#pp#ww#...",
            "...#wwwwwwww#...",
            "....########....",
            ".....#w..w#.....",
            "......####......",
            "................",
            "................",
            "................",
        ]),
    ]

    private static let moonrabbitStage2: [PixelSprite] = [
        s(moonrabbitPalette, [
            "................",
            "...#........#...",
            "...#ww......ww#.",
            "...#ww......ww#.",
            "...#ww......ww#.",
            "..#wwwwwwwwwwww#",
            "..#wwl####lwwww#",
            "..#wwwwwwwwwwww#",
            "..#wwww#pp#wwww#",
            "..#wwwwwwwwwwww#",
            "...#############",
            "....#ww....ww#..",
            "....#w######w#..",
            ".....########...",
            "................",
            "................",
        ]),
        s(moonrabbitPalette, [
            "................",
            "...#........#...",
            "...#ww......ww#.",
            "...#ww......ww#.",
            "...#ww......ww#.",
            "..#wwwwwwwwwwww#",
            "..#ww########ww#",
            "..#wwwwwwwwwwww#",
            "..#wwww#pp#wwww#",
            "..#wwwwwwwwwwww#",
            "...#############",
            "....#ww....ww#..",
            "....#w######w#..",
            ".....########...",
            "................",
            "................",
        ]),
    ]

    private static let moonrabbitStage3: [PixelSprite] = [
        s(moonrabbitPalette, [
            "..#..........#..",
            "..#ww........ww#",
            "..#ww........ww#",
            "..#ww........ww#",
            ".#wwwwwwwwwwwwww",
            ".#wwwl####lwwwww",
            ".#wwwwwwwwwwwwww",
            ".#wwwww#pp#wwwww",
            ".#wwwwwwwwwwwwww",
            ".#wwwwwwwwwwwwww",
            "..##############",
            "...#www....www#.",
            "...#wwww##wwww#.",
            "....#w######w#..",
            ".....########...",
            "................",
        ]),
        s(moonrabbitPalette, [
            "..#..........#..",
            "..#ww........ww#",
            "..#ww........ww#",
            "..#ww........ww#",
            ".#wwwwwwwwwwwwww",
            ".#www##########w",
            ".#wwwwwwwwwwwwww",
            ".#wwwww#pp#wwwww",
            ".#wwwwwwwwwwwwww",
            ".#wwwwwwwwwwwwww",
            "..##############",
            "...#www....www#.",
            "...#wwww##wwww#.",
            "....#w######w#..",
            ".....########...",
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
