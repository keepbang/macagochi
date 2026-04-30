import SwiftUI
import DamagochiCore
import DamagochiRenderer

/// Renders the pet with each equipped item overlaid.
/// When `isDraggable` is true, each item can be dragged to reposition it.
struct EquippedPetView: View {
    @ObservedObject var viewModel: PetViewModel
    let scale: CGFloat
    let interval: TimeInterval
    var isDraggable: Bool = false

    var body: some View {
        let baseFrames = viewModel.baseFrames
        let baseWidth = CGFloat(baseFrames.first?.width ?? 16) * scale
        let baseHeight = CGFloat(baseFrames.first?.height ?? 16) * scale

        ZStack {
            AnimatedPetView(frames: baseFrames, scale: scale, interval: interval)

            ForEach(viewModel.equippedOverlays, id: \.slot) { overlay in
                if isDraggable {
                    DraggableEquipmentOverlay(
                        viewModel: viewModel,
                        overlay: overlay,
                        scale: scale
                    )
                } else {
                    StaticEquipmentOverlay(
                        viewModel: viewModel,
                        overlay: overlay,
                        scale: scale
                    )
                }
            }
        }
        .frame(width: baseWidth, height: baseHeight)
    }
}

// MARK: - Static Overlay (read-only, no interaction)

private struct StaticEquipmentOverlay: View {
    @ObservedObject var viewModel: PetViewModel
    let overlay: SpriteSheet.EquippedOverlay
    let scale: CGFloat

    var body: some View {
        let off = viewModel.equipmentOffset(for: overlay.slot)
        PixelArtView(sprite: overlay.sprite, scale: scale)
            .offset(x: CGFloat(off.x) * scale, y: CGFloat(off.y) * scale)
            .allowsHitTesting(false)
    }
}

// MARK: - Draggable Overlay

private struct DraggableEquipmentOverlay: View {
    @ObservedObject var viewModel: PetViewModel
    let overlay: SpriteSheet.EquippedOverlay
    let scale: CGFloat

    @State private var dragStart: PixelOffset?
    @State private var isHovering = false

    var body: some View {
        let off = viewModel.equipmentOffset(for: overlay.slot)
        let bounds = overlay.sprite.visibleBounds
            ?? CGRect(x: 0, y: 0, width: overlay.sprite.width, height: overlay.sprite.height)
        let scaledBounds = CGRect(
            x: bounds.minX * scale,
            y: bounds.minY * scale,
            width: bounds.width * scale,
            height: bounds.height * scale
        )

        PixelArtView(sprite: overlay.sprite, scale: scale)
            .overlay(
                OverlayHitShape(rect: scaledBounds)
                    .stroke(
                        Color.accentColor.opacity(isHovering || dragStart != nil ? 0.85 : 0),
                        style: StrokeStyle(lineWidth: 1, dash: [3, 2])
                    )
                    .allowsHitTesting(false)
            )
            .offset(x: CGFloat(off.x) * scale, y: CGFloat(off.y) * scale)
            .contentShape(PixelHitShape(sprite: overlay.sprite, scale: scale))
            .onHover { isHovering = $0 }
            .help("드래그해서 위치 조정 · 더블클릭으로 초기화")
            .onTapGesture(count: 2) {
                viewModel.resetEquipmentOffset(for: overlay.slot)
            }
            .gesture(dragGesture(currentOffset: off))
    }

    private func dragGesture(currentOffset: PixelOffset) -> some Gesture {
        DragGesture(minimumDistance: 1)
            .onChanged { value in
                if dragStart == nil { dragStart = currentOffset }
                let start = dragStart ?? currentOffset
                let dx = Int((value.translation.width / scale).rounded())
                let dy = Int((value.translation.height / scale).rounded())
                viewModel.setEquipmentOffset(
                    PixelOffset(x: start.x + dx, y: start.y + dy),
                    for: overlay.slot
                )
            }
            .onEnded { _ in
                dragStart = nil
                viewModel.save()
            }
    }
}

// MARK: - Shapes

/// Bounding-box shape used for the dashed visual border.
private struct OverlayHitShape: Shape {
    let rect: CGRect
    func path(in _: CGRect) -> Path {
        Path(rect)
    }
}

/// Pixel-accurate hit shape — only covers non-transparent pixels so overlapping
/// overlays don't block each other's drag gestures.
private struct PixelHitShape: Shape {
    let sprite: PixelSprite
    let scale: CGFloat

    func path(in _: CGRect) -> Path {
        var path = Path()
        for row in 0..<sprite.height {
            for col in 0..<sprite.width {
                guard !sprite.pixels[row][col].isTransparent else { continue }
                path.addRect(CGRect(
                    x: CGFloat(col) * scale,
                    y: CGFloat(row) * scale,
                    width: scale,
                    height: scale
                ))
            }
        }
        return path
    }
}
