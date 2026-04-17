import SwiftUI
import DamagochiCore

public enum PixelColor: UInt32, Sendable {
    case clear = 0x00000000
    case black = 0xFF000000
    case white = 0xFFFFFFFF
    case primary = 0xFF4A9EFF
    case secondary = 0xFFFFA500
}

public struct PixelSprite: Sendable {
    public let width: Int
    public let height: Int
    public let pixels: [[PixelColor]]

    public init(width: Int, height: Int, pixels: [[PixelColor]]) {
        self.width = width
        self.height = height
        self.pixels = pixels
    }
}

public struct PixelArtView: View {
    let sprite: PixelSprite
    let scale: CGFloat

    public init(sprite: PixelSprite, scale: CGFloat = 4.0) {
        self.sprite = sprite
        self.scale = scale
    }

    public var body: some View {
        Canvas { context, size in
            for row in 0..<sprite.height {
                for col in 0..<sprite.width {
                    let color = sprite.pixels[row][col]
                    guard color != .clear else { continue }
                    let rect = CGRect(
                        x: CGFloat(col) * scale,
                        y: CGFloat(row) * scale,
                        width: scale,
                        height: scale
                    )
                    context.fill(Path(rect), with: .color(Color(hex: color.rawValue)))
                }
            }
        }
        .frame(width: CGFloat(sprite.width) * scale, height: CGFloat(sprite.height) * scale)
        .drawingGroup()
    }
}

extension Color {
    init(hex: UInt32) {
        let a = Double((hex >> 24) & 0xFF) / 255.0
        let r = Double((hex >> 16) & 0xFF) / 255.0
        let g = Double((hex >> 8) & 0xFF) / 255.0
        let b = Double(hex & 0xFF) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}
