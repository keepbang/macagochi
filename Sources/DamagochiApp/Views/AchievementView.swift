import SwiftUI
import DamagochiCore

struct AchievementView: View {
    @ObservedObject var viewModel: PetViewModel

    private var allAchievements: [Achievement] {
        AchievementChecker.allAchievements.map { achievement in
            var a = achievement
            if viewModel.state.unlockedAchievements.contains(achievement.id) {
                a.unlockedAt = Date()
            }
            return a
        }
    }

    private var unlockedCount: Int {
        viewModel.state.unlockedAchievements.count
    }

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            achievementList
        }
    }

    private var header: some View {
        VStack(spacing: 4) {
            Text("업적")
                .font(.headline)
            Text("\(unlockedCount) / \(AchievementChecker.allAchievements.count)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 8)
    }

    private var achievementList: some View {
        ScrollView {
            LazyVStack(spacing: 4) {
                ForEach(AchievementTier.allCases, id: \.self) { tier in
                    let items = allAchievements.filter { $0.tier == tier }
                    if !items.isEmpty {
                        tierSection(tier: tier, items: items)
                    }
                }
            }
            .padding(8)
        }
    }

    private func tierSection(tier: AchievementTier, items: [Achievement]) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(tierLabel(tier))
                .font(.caption2.bold())
                .foregroundStyle(.secondary)
                .padding(.leading, 4)

            ForEach(items) { achievement in
                achievementRow(achievement)
            }
        }
    }

    private func achievementRow(_ achievement: Achievement) -> some View {
        HStack(spacing: 8) {
            Text(tierEmoji(achievement.tier))
                .font(.title3)
                .opacity(achievement.isUnlocked ? 1 : 0.3)

            VStack(alignment: .leading, spacing: 1) {
                Text(achievement.name)
                    .font(.caption.bold())
                    .foregroundStyle(achievement.isUnlocked ? .primary : .tertiary)
                Text(achievement.description)
                    .font(.caption2)
                    .foregroundStyle(achievement.isUnlocked ? .secondary : .tertiary)
            }

            Spacer()

            if achievement.isUnlocked {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
                    .font(.caption)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(achievement.isUnlocked ? Color.green.opacity(0.05) : Color.clear)
        )
    }

    private func tierLabel(_ tier: AchievementTier) -> String {
        switch tier {
        case .bronze:  return "🥉 브론즈"
        case .silver:  return "🥈 실버"
        case .gold:    return "🥇 골드"
        case .diamond: return "💎 다이아몬드"
        }
    }

    private func tierEmoji(_ tier: AchievementTier) -> String {
        switch tier {
        case .bronze:  return "🥉"
        case .silver:  return "🥈"
        case .gold:    return "🥇"
        case .diamond: return "💎"
        }
    }
}

extension AchievementTier: CaseIterable {
    public static var allCases: [AchievementTier] {
        [.bronze, .silver, .gold, .diamond]
    }
}
