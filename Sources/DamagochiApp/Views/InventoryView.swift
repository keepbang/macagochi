import SwiftUI
import DamagochiCore
import DamagochiRenderer

struct InventoryView: View {
    @ObservedObject var viewModel: PetViewModel

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()

            if viewModel.state.inventory.isEmpty {
                emptyState
            } else {
                inventoryContent
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        HStack {
            Text("장비")
                .font(.headline)
            Spacer()
            Text("\(viewModel.state.inventory.count)개 보유")
                .font(.caption)
                .foregroundStyle(.secondary)
                .monospacedDigit()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
    }

    // MARK: - Content

    private var inventoryContent: some View {
        ScrollView {
            VStack(spacing: 10) {
                if viewModel.state.phase == .alive && hasEquippedItems {
                    positionSection
                    Divider()
                }
                equippedSection
                Divider()
                allItemsSection
            }
            .padding(10)
            .frame(maxWidth: .infinity)
        }
    }

    // MARK: - Position Adjustment Section

    private var hasEquippedItems: Bool {
        viewModel.state.equippedItems.head != nil ||
        viewModel.state.equippedItems.hand != nil ||
        viewModel.state.equippedItems.effect != nil
    }

    private var positionSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("위치 조정")
                .font(.caption.bold())
                .foregroundStyle(.secondary)

            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.quaternary.opacity(0.3))

                EquippedPetView(
                    viewModel: viewModel,
                    scale: 7.0,
                    interval: 0.5,
                    isDraggable: true
                )
            }
            .frame(height: 120)

            Text("아이템을 드래그하여 위치를 조정하세요 · 더블클릭으로 초기화")
                .font(.caption2)
                .foregroundStyle(.tertiary)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }

    // MARK: - Equipped Slots

    private var equippedSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("장착 중")
                .font(.caption.bold())
                .foregroundStyle(.secondary)

            HStack(spacing: 8) {
                ForEach(EquipmentSlot.allCases, id: \.self) { slot in
                    equippedSlotCard(slot)
                }
            }
        }
    }

    private func equippedSlotCard(_ slot: EquipmentSlot) -> some View {
        let item = viewModel.equippedItem(for: slot)
        return VStack(spacing: 4) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(item != nil ? rarityColor(item!.rarity).opacity(0.15) : Color.secondary.opacity(0.08))
                    .frame(height: 44)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(item != nil ? rarityColor(item!.rarity).opacity(0.4) : Color.clear, lineWidth: 1)
                    )

                if let item {
                    VStack(spacing: 2) {
                        Text(rarityEmoji(item.rarity))
                            .font(.title3)
                        Text(item.name)
                            .font(.system(size: 8))
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                    .padding(.horizontal, 2)
                } else {
                    VStack(spacing: 2) {
                        Image(systemName: slotIcon(slot))
                            .font(.system(size: 14))
                            .foregroundStyle(.tertiary)
                        Text(slotLabel(slot))
                            .font(.system(size: 8))
                            .foregroundStyle(.tertiary)
                    }
                }
            }

            Button("해제") {
                if item != nil { viewModel.unequip(slot: slot) }
            }
            .font(.system(size: 9))
            .foregroundStyle(.red)
            .buttonStyle(.plain)
            .opacity(item != nil ? 1 : 0)
        }
        .frame(maxWidth: .infinity)
    }

    private var allItemsSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("인벤토리")
                .font(.caption.bold())
                .foregroundStyle(.secondary)

            VStack(spacing: 0) {
                ForEach(viewModel.state.inventory) { item in
                    ItemRow(item: item, isEquipped: isItemEquipped(item)) {
                        if isItemEquipped(item) {
                            viewModel.unequip(slot: item.slot)
                        } else {
                            viewModel.equip(itemId: item.id)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: 10) {
            Spacer()
            Image(systemName: "bag")
                .font(.system(size: 32))
                .foregroundStyle(.quaternary)
            Text("장비가 없습니다")
                .font(.caption.bold())
                .foregroundStyle(.secondary)
            Text("레벨업 시 장비를 획득할 수 있어요")
                .font(.caption2)
                .foregroundStyle(.tertiary)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
    }

    // MARK: - Helpers

    private func isItemEquipped(_ item: Equipment) -> Bool {
        switch item.slot {
        case .head:   return viewModel.state.equippedItems.head == item.id
        case .hand:   return viewModel.state.equippedItems.hand == item.id
        case .effect: return viewModel.state.equippedItems.effect == item.id
        }
    }

    private func rarityEmoji(_ rarity: Rarity) -> String {
        switch rarity {
        case .common:    return "⚪"
        case .rare:      return "🔵"
        case .legendary: return "🟡"
        case .mythic:    return "🌈"
        }
    }

    private func rarityColor(_ rarity: Rarity) -> Color {
        switch rarity {
        case .common:    return .gray
        case .rare:      return .blue
        case .legendary: return .yellow
        case .mythic:    return .purple
        }
    }

    private func slotIcon(_ slot: EquipmentSlot) -> String {
        switch slot {
        case .head:   return "crown"
        case .hand:   return "hand.raised"
        case .effect: return "sparkle"
        }
    }

    private func slotLabel(_ slot: EquipmentSlot) -> String {
        switch slot {
        case .head:   return "머리"
        case .hand:   return "손"
        case .effect: return "효과"
        }
    }
}

// MARK: - Item Row

private struct ItemRow: View {
    let item: Equipment
    let isEquipped: Bool
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(rarityColor.opacity(0.12))
                    .frame(width: 32, height: 32)
                Text(rarityEmoji)
                    .font(.body)
            }

            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 4) {
                    Text(item.name)
                        .font(.caption.bold())
                    Text("[\(slotLabel)]")
                        .font(.system(size: 9))
                        .foregroundStyle(.secondary)
                    if isEquipped {
                        Text("장착")
                            .font(.system(size: 9, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 1)
                            .background(rarityColor, in: Capsule())
                    }
                }
                Text(item.description)
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
                    .lineLimit(1)
            }

            Spacer()

            Button(isEquipped ? "해제" : "장착") {
                onToggle()
            }
            .buttonStyle(.bordered)
            .controlSize(.mini)
            .tint(isEquipped ? .red : rarityColor)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(isEquipped ? rarityColor.opacity(0.06) : Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isEquipped ? rarityColor.opacity(0.3) : Color.clear, lineWidth: 0.5)
                )
        )
    }

    private var rarityEmoji: String {
        switch item.rarity {
        case .common:    return "⚪"
        case .rare:      return "🔵"
        case .legendary: return "🟡"
        case .mythic:    return "🌈"
        }
    }

    private var rarityColor: Color {
        switch item.rarity {
        case .common:    return .gray
        case .rare:      return .blue
        case .legendary: return .orange
        case .mythic:    return .purple
        }
    }

    private var slotLabel: String {
        switch item.slot {
        case .head:   return "머리"
        case .hand:   return "손"
        case .effect: return "효과"
        }
    }
}
