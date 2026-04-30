import SwiftUI
import DamagochiCore
import DamagochiRenderer

/// Renders the pet with each equipped item as a separately-positioned overlay
/// so the user can drag any item with the mouse to reposition it.
struct EquippedPetView: View {
    @ObservedObject var viewModel: PetViewModel
    let scale: CGFloat
    let interval: TimeInterval

    var body: some View {
        let baseFrames = viewModel.baseFrames
        let baseWidth = CGFloat(baseFrames.first?.width ?? 16) * scale
        let baseHeight = CGFloat(baseFrames.first?.height ?? 16) * scale

        ZStack {
            AnimatedPetView(frames: baseFrames, scale: scale, interval: interval)

            ForEach(viewModel.equippedOverlays, id: \.slot) { overlay in
                DraggableEquipmentOverlay(
                    viewModel: viewModel,
                    overlay: overlay,
                    scale: scale
                )
            }
        }
        .frame(width: baseWidth, height: baseHeight)
    }
}

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
            .contentShape(OverlayHitShape(rect: scaledBounds))
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

/// Restricts hit-testing to the sprite's non-transparent bounding rectangle so
/// that overlays can be picked individually even when their 16x16 frames overlap.
private struct OverlayHitShape: Shape {
    let rect: CGRect
    func path(in _: CGRect) -> Path {
        Path(rect)
    }
}
