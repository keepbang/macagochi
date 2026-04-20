import SwiftUI
import DamagochiCore

struct SettingsView: View {
    @ObservedObject var viewModel: PetViewModel

    var body: some View {
        VStack(spacing: 0) {
            Text("설정")
                .font(.headline)
                .padding(.vertical, 8)

            Divider()

            ScrollView {
                VStack(spacing: 12) {
                    hookSection
                    notificationSection
                    petInfoSection
                    appInfoSection
                }
                .padding(12)
            }
        }
    }

    // MARK: - Hook Section

    private var hookSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Claude Code 연동", systemImage: "link.circle.fill")
                .font(.caption.bold())

            HStack {
                Circle()
                    .fill(viewModel.hookInstalled ? .green : .red)
                    .frame(width: 8, height: 8)
                Text(viewModel.hookInstalled ? "Hook 설치됨" : "Hook 미설치")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()

                if viewModel.hookInstalled {
                    Button("제거") {
                        viewModel.uninstallHooks()
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.mini)
                    .tint(.red)
                } else {
                    Button("설치") {
                        viewModel.installHooks()
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.mini)
                }
            }

            Text("Claude Code 사용 시 자동으로 경험치를 획득합니다")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 8).fill(.quaternary.opacity(0.3)))
    }

    // MARK: - Notification Section

    private var notificationSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("알림", systemImage: "bell.fill")
                .font(.caption.bold())

            Toggle(isOn: $viewModel.notificationsEnabled) {
                Text("시스템 알림")
                    .font(.caption)
            }
            .toggleStyle(.switch)
            .controlSize(.mini)

            Text("레벨업, 부화, 장비 획득, 사망 위험 등을 알려줍니다")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 8).fill(.quaternary.opacity(0.3)))
    }

    // MARK: - Pet Info

    private var petInfoSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("펫 정보", systemImage: "info.circle.fill")
                .font(.caption.bold())

            infoRow("상태", value: phaseText)
            if let species = viewModel.state.species {
                infoRow("종족", value: speciesName(species))
            }
            if let personality = viewModel.state.personality {
                infoRow("성격", value: personality)
            }
            infoRow("단계", value: stageText)
            infoRow("총 XP", value: "\(viewModel.state.totalXp)")
            infoRow("연속 근무일", value: "\(viewModel.state.consecutiveWorkdays)일")
            infoRow("사망 횟수", value: "\(viewModel.state.deathCount)회")
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 8).fill(.quaternary.opacity(0.3)))
    }

    // MARK: - App Info

    private var appInfoSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("앱 정보", systemImage: "app.badge.fill")
                .font(.caption.bold())

            infoRow("이름", value: "Damagochi")
            infoRow("버전", value: "1.0.0")
            infoRow("플랫폼", value: "macOS 14+")

            HStack {
                Spacer()
                Text("Claude Code 사용량 기반 가상 펫")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
                Spacer()
            }

            Divider()

            Button(action: { NSApplication.shared.terminate(nil) }) {
                Label("앱 종료", systemImage: "power")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .controlSize(.small)
            .tint(.red)
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 8).fill(.quaternary.opacity(0.3)))
    }

    // MARK: - Helpers

    private func infoRow(_ label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.caption.monospacedDigit())
        }
    }

    private var phaseText: String {
        switch viewModel.state.phase {
        case .egg:   return "알"
        case .alive: return "생존"
        case .dead:  return "사망"
        }
    }

    private var stageText: String {
        switch viewModel.state.stage {
        case .stage1: return "Stage 1 (아기)"
        case .stage2: return "Stage 2 (성장)"
        case .stage3: return "Stage 3 (완전체)"
        }
    }

    private func speciesName(_ id: String) -> String {
        Species.allSpecies.first(where: { $0.id == id })?.name ?? id
    }
}
