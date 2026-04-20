import SwiftUI
import DamagochiCore

struct InventoryView: View {
    @ObservedObject var viewModel: PetViewModel

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()

            if viewModel.state.inventory.isEmpty {
                emptyState
            } else {
                equipmentList
            }
        }
    }

    private var header: some View {
        VStack(spacing: 4) {
            Text("장비")
                .font(.headline)

            HStack(spacing: 12) {
                ForEach(EquipmentSlot.allCases, id: \.self) { slot in
                    slotView(slot)
                }
            }
            .padding(.bottom, 6)
        }
        .padding(.top, 8)
    }

    private func slotView(_ slot: EquipmentSlot) -> some View {
        VStack(spacing: 2) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(.quaternary)
                    .frame(width: 40, height: 40)

                if let item = viewModel.equippedItem(for: slot) {
                    Text(rarityEmoji(item.rarity))
                        .font(.title2)
                } else {
                    Image(systemName: slotIcon(slot))
                        .foregroundStyle(.tertiary)
                }
            }

            Text(slotLabel(slot))
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }

    private var equipmentList: some View {
        ScrollView {
            LazyVStack(spacing: 4) {
                ForEach(viewModel.state.inventory) { item in
                    equipmentRow(item)
                }
            }
            .padding(8)
        }
    }

    private func equipmentRow(_ item: Equipment) -> some View {
        let isEquipped = isItemEquipped(item)

        return HStack(spacing: 8) {
            Text(rarityEmoji(item.rarity))
                .font(.title3)

            VStack(alignment: .leading, spacing: 1) {
                HStack(spacing: 4) {
                    Text(item.name)
                        .font(.caption.bold())
                    Text("[\(slotLabel(item.slot))]")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                Text(item.description)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer()

            if isEquipped {
                Button("해제") {
                    viewModel.unequip(slot: item.slot)
                }
                .buttonStyle(.bordered)
                .controlSize(.mini)
                .tint(.red)
            } else {
                Button("장착") {
                    viewModel.equip(itemId: item.id)
                }
                .buttonStyle(.bordered)
                .controlSize(.mini)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(isEquipped ? Color.blue.opacity(0.08) : Color.clear)
        )
    }

    private var emptyState: some View {
        VStack(spacing: 8) {
            Spacer()
            Image(systemName: "bag")
                .font(.largeTitle)
                .foregroundStyle(.tertiary)
            Text("장비가 없습니다")
                .font(.caption)
                .foregroundStyle(.secondary)
            Text("레벨업 시 장비를 획득할 수 있어요")
                .font(.caption2)
                .foregroundStyle(.tertiary)
            Spacer()
        }
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
        case .mythic:    return "🟣"
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
