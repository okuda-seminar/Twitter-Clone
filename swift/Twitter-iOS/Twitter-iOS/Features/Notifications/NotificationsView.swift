//

import SwiftUI

struct NotificationsTabModel: Identifiable {
  private(set) var id: Tab
  var size: CGSize = .zero
  var minX: CGFloat = .zero

  enum Tab: String, CaseIterable {
    case all = "All"
    case verified = "Verified"
    case mentions = "Mentions"
  }
}

struct NotificationsView: View {
  @State private var tabs: [NotificationsTabModel] = [
    .init(id: .all),
    .init(id: .verified),
    .init(id: .mentions),
  ]
  @State private var activeTab: NotificationsTabModel.Tab = .all
  @State private var tabScrollState: NotificationsTabModel.Tab?

  var body: some View {
    VStack {
      TabBar()

      GeometryReader { reader in
        let size = reader.size

        ScrollView(.horizontal) {
          LazyHStack(spacing: 0) {
            ForEach(tabs) { tab in
              Text(tab.id.rawValue)
                .frame(width: size.width, height: 100, alignment: .center)
            }
          }
          .scrollTargetLayout()
        }
        .scrollPosition(id: $tabScrollState)
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .onChange(of: tabScrollState) { oldValue, newValue in
          if let newValue {
            withAnimation {
              tabScrollState = newValue
              activeTab = newValue
            }
          }
        }
      }
    }
  }

  @ViewBuilder
  private func TabBar() -> some View {
    ScrollView(.horizontal) {
      HStack(spacing: 40) {
        Spacer()
        ForEach(tabs) { tab in
          Button(
            action: {
              withAnimation(.snappy) {
                activeTab = tab.id
                tabScrollState = tab.id
              }
            },
            label: {
              Text(tab.id.rawValue)
                .padding(.vertical, 12)
                .foregroundStyle(activeTab == tab.id ? Color.primary : .gray)
                .contentShape(.rect)
            }
          )
          .buttonStyle(.plain)

          Spacer()
        }
      }
      .scrollTargetLayout()
    }
    .overlay(alignment: .bottom) {
      ZStack(alignment: .leading) {
        Rectangle()
          .fill(.gray.opacity(0.3))
          .frame(height: 1)
      }
    }
    .scrollIndicators(.hidden)
  }
}

#Preview {
  NotificationsView()
}
