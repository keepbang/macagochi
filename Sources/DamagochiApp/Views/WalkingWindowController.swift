import AppKit
import Combine
import SwiftUI

@MainActor
final class WalkingWindowController {
    private var panel: NSPanel?
    private var hostingController: NSHostingController<WalkingPetView>?
    private let viewModel: PetViewModel
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: PetViewModel) {
        self.viewModel = viewModel
    }

    func show() {
        guard panel == nil else { return }

        let hostingController = NSHostingController(rootView: WalkingPetView(viewModel: viewModel))

        let panel = NSPanel(
            contentRect: NSRect(x: 0, y: 0, width: 160, height: 180),
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        panel.isFloatingPanel = true
        panel.level = .floating
        panel.backgroundColor = .clear
        panel.isOpaque = false
        panel.hasShadow = false
        panel.isMovableByWindowBackground = true
        panel.contentViewController = hostingController
        panel.setContentSize(hostingController.view.fittingSize)

        if let screen = NSScreen.main {
            let f = screen.visibleFrame
            let s = panel.frame.size
            panel.setFrameOrigin(NSPoint(x: f.maxX - s.width - 24, y: f.minY + 120))
        }

        panel.orderFront(nil)
        self.panel = panel
        self.hostingController = hostingController

        viewModel.$walkSpeechBubble
            .removeDuplicates { ($0 == nil) == ($1 == nil) }
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.resizePanelKeepingBottom()
            }
            .store(in: &cancellables)
    }

    func hide() {
        cancellables.removeAll()
        panel?.close()
        panel = nil
        hostingController = nil
    }

    private func resizePanelKeepingBottom() {
        guard let panel, let hostingController else { return }
        // Wait one tick for SwiftUI to lay out the new content.
        DispatchQueue.main.async { [weak panel, weak hostingController] in
            guard let panel, let hostingController else { return }
            let oldFrame = panel.frame
            let newSize = hostingController.view.fittingSize
            let newOrigin = NSPoint(
                x: oldFrame.origin.x,
                y: oldFrame.origin.y - (newSize.height - oldFrame.size.height)
            )
            panel.setFrame(NSRect(origin: newOrigin, size: newSize), display: true, animate: false)
        }
    }
}
