import AppKit
import SwiftUI
import DamagochiCore
import DamagochiRenderer
import Combine

final class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem?
    private var popover: NSPopover?
    let viewModel = PetViewModel()
    private var stateSubscription: AnyCancellable?

    func applicationDidFinishLaunching(_ notification: Notification) {
        viewModel.start()

        let popover = NSPopover()
        popover.contentSize = NSSize(width: 280, height: 420)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: PopoverView(viewModel: viewModel))
        self.popover = popover

        let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem.button {
            updateMenuBarIcon(button: button)
            button.action = #selector(togglePopover(_:))
            button.target = self
        }
        self.statusItem = statusItem

        stateSubscription = viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let button = self?.statusItem?.button else { return }
                self?.updateMenuBarIcon(button: button)
            }
    }

    func applicationWillTerminate(_ notification: Notification) {
        viewModel.stop()
    }

    @objc private func togglePopover(_ sender: AnyObject?) {
        guard let popover = popover, let button = statusItem?.button else { return }
        if popover.isShown {
            popover.performClose(sender)
        } else {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            popover.contentViewController?.view.window?.makeKey()
        }
    }

    private func updateMenuBarIcon(button: NSStatusBarButton) {
        let sprite = SpriteSheet.menuBarIcon(
            phase: viewModel.state.phase,
            stage: viewModel.state.stage
        )
        let size = CGFloat(sprite.width) * 2.0
        let image = NSImage(size: NSSize(width: size, height: size), flipped: false) { rect in
            guard let context = NSGraphicsContext.current?.cgContext else { return false }
            let scale: CGFloat = 2.0
            for row in 0..<sprite.height {
                for col in 0..<sprite.width {
                    let px = sprite.pixels[row][col]
                    guard !px.isTransparent else { continue }
                    let r = CGFloat((px.rawValue >> 16) & 0xFF) / 255.0
                    let g = CGFloat((px.rawValue >> 8) & 0xFF) / 255.0
                    let b = CGFloat(px.rawValue & 0xFF) / 255.0
                    let a = CGFloat((px.rawValue >> 24) & 0xFF) / 255.0
                    context.setFillColor(CGColor(red: r, green: g, blue: b, alpha: a))
                    let pixelRect = CGRect(
                        x: CGFloat(col) * scale,
                        y: CGFloat(sprite.height - 1 - row) * scale,
                        width: scale,
                        height: scale
                    )
                    context.fill(pixelRect)
                }
            }
            return true
        }
        image.isTemplate = false
        button.image = image
    }
}
