import SwiftUI
import DamagochiCore

struct GraveyardView: View {
    @ObservedObject var viewModel: PetViewModel

    private var entries: [GraveyardEntry] {
        viewModel.state.graveyardEntries.reversed()
    }

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()

            if entries.isEmpty {
                emptyState
            } else {
                entryList
            }
        }
    }

    private var header: some View {
        VStack(spacing: 4) {
            Text("묘지")
                .font(.headline)
            if !entries.isEmpty {
                Text("역대 펫 \(entries.count)마리")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 8)
    }

    private var entryList: some View {
        ScrollView {
            LazyVStack(spacing: 6) {
                ForEach(entries) { entry in
                    entryRow(entry)
                }
            }
            .padding(8)
        }
    }

    private func entryRow(_ entry: GraveyardEntry) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("🪦")
                    .font(.title3)
                VStack(alignment: .leading, spacing: 1) {
                    HStack(spacing: 4) {
                        Text(entry.name ?? speciesName(entry.species))
                            .font(.caption.bold())
                        if let personality = entry.personality {
                            Text(personality)
                                .font(.caption2)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 1)
                                .background(.quaternary, in: Capsule())
                        }
                    }
                    Text("Lv.\(entry.level) · XP \(entry.totalXp)")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }

            HStack(spacing: 8) {
                Label(formatDate(entry.bornAt) + " ~ " + formatDate(entry.diedAt), systemImage: "calendar")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }

            Text("사인: \(entry.causeOfDeath)")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.quaternary.opacity(0.3))
        )
    }

    private var emptyState: some View {
        VStack(spacing: 8) {
            Spacer()
            Image(systemName: "leaf")
                .font(.largeTitle)
                .foregroundStyle(.tertiary)
            Text("아직 이곳은 비어있습니다")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text("오래오래 함께 해주세요")
                .font(.caption2)
                .foregroundStyle(.tertiary)
            Spacer()
        }
    }

    private func speciesName(_ id: String?) -> String {
        guard let id else { return "???" }
        return Species.allSpecies.first(where: { $0.id == id })?.name ?? id
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter.string(from: date)
    }
}
