import SwiftUI
import DamagochiCore

struct PopoverView: View {
    @ObservedObject var viewModel: PetViewModel

    var body: some View {
        VStack(spacing: 12) {
            petEmoji
                .font(.system(size: 64))

            Text(viewModel.state.name ?? "Damagochi")
                .font(.headline)

            statusSection

            statsSection
        }
        .frame(width: 280, height: 400)
        .padding()
    }

    private var petEmoji: some View {
        switch viewModel.state.phase {
        case .egg:
            Text("🥚")
        case .alive:
            Text("🐣")
        case .dead:
            Text("💀")
        }
    }

    private var statusSection: some View {
        VStack(spacing: 4) {
            statusBar(label: "HP", value: viewModel.state.hp, color: .red)
            statusBar(label: "배고픔", value: viewModel.state.hunger, color: .orange)
            statusBar(label: "기분", value: viewModel.state.mood, color: .blue)
        }
    }

    private func statusBar(label: String, value: Int, color: Color) -> some View {
        HStack {
            Text(label)
                .font(.caption)
                .frame(width: 40, alignment: .leading)
            ProgressView(value: Double(value), total: 100)
                .tint(color)
            Text("\(value)")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .frame(width: 28, alignment: .trailing)
        }
    }

    private var statsSection: some View {
        VStack(spacing: 4) {
            HStack {
                Text("Lv.\(viewModel.state.level)")
                    .font(.subheadline.bold())
                Spacer()
                Text("XP: \(viewModel.state.xp)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Divider()

            HStack {
                statItem(icon: "text.bubble", count: viewModel.state.totalPrompts)
                Spacer()
                statItem(icon: "wrench", count: viewModel.state.totalToolUses)
                Spacer()
                statItem(icon: "play.circle", count: viewModel.state.totalSessions)
            }
            .font(.caption)
        }
        .padding(.top, 8)
    }

    private func statItem(icon: String, count: Int) -> some View {
        HStack(spacing: 2) {
            Image(systemName: icon)
            Text("\(count)")
        }
    }
}
