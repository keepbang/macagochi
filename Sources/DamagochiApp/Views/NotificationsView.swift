import SwiftUI

struct NotificationsView: View {
    @ObservedObject var viewModel: PetViewModel

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("알림")
                    .font(.headline)
                Spacer()
                if !viewModel.walkNotifications.isEmpty {
                    Button("전체 삭제") {
                        viewModel.walkNotifications.removeAll()
                    }
                    .font(.caption)
                    .foregroundStyle(.red)
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)

            Divider()

            if viewModel.walkNotifications.isEmpty {
                VStack(spacing: 8) {
                    Spacer()
                    Image(systemName: "bell.slash")
                        .font(.system(size: 28))
                        .foregroundStyle(.quaternary)
                    Text("알림이 없어요")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                    Spacer()
                }
            } else {
                ScrollView {
                    LazyVStack(spacing: 6) {
                        ForEach(viewModel.walkNotifications) { item in
                            notificationRow(item)
                        }
                    }
                    .padding(10)
                }
            }
        }
    }

    private func notificationRow(_ item: WalkNotification) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text(notificationIcon(item.message))
                .font(.caption)
                .frame(width: 16)
                .padding(.top, 1)

            VStack(alignment: .leading, spacing: 2) {
                Text(item.message)
                    .font(.caption)
                    .foregroundStyle(.primary)
                Text(relativeTime(item.timestamp))
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }

            Spacer()

            Button(action: { viewModel.dismissWalkNotification(id: item.id) }) {
                Image(systemName: "xmark")
                    .font(.system(size: 10))
                    .foregroundStyle(.secondary)
            }
            .buttonStyle(.plain)
        }
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 8).fill(.quaternary.opacity(0.3)))
    }

    private func notificationIcon(_ message: String) -> String {
        if message.contains("레벨") { return "⬆️" }
        if message.contains("부화") { return "🐣" }
        if message.contains("장비") || message.contains("획득") { return "🎁" }
        if message.contains("업적") || message.contains("달성") { return "🏆" }
        if message.contains("스트릭") || message.contains("연속") { return "🔥" }
        if message.contains("방생") { return "🕊️" }
        if message.contains("사망") { return "💀" }
        if message.contains("작업") { return "✅" }
        return "💬"
    }

    private func relativeTime(_ date: Date) -> String {
        let diff = Int(Date().timeIntervalSince(date))
        if diff < 60 { return "방금 전" }
        if diff < 3600 { return "\(diff / 60)분 전" }
        if diff < 86400 { return "\(diff / 3600)시간 전" }
        return "\(diff / 86400)일 전"
    }
}
