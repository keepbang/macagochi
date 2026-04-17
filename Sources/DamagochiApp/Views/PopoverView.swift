import SwiftUI

struct PopoverView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("🥚")
                .font(.system(size: 64))
            Text("Damagochi")
                .font(.headline)
            Text("준비 중...")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 280, height: 400)
    }
}
