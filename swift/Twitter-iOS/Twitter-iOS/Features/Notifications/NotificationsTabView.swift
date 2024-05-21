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

struct NotificationsTabView: View {
  @State private var tabs: [NotificationsTabModel] = [
    .init(id: .all),
    .init(id: .verified),
    .init(id: .mentions),
  ]
  @State private var activeTab: NotificationsTabModel.Tab = .all
  @State private var tabScrollState: NotificationsTabModel.Tab?
  @State private var progress: CGFloat = .zero

  var body: some View {
    VStack(spacing: 0) {
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
          .rect { rect in
            progress = -rect.minX / size.width
          }
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
        ForEach($tabs) { $tab in
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
          .rect { rect in
            tab.size = rect.size
            tab.minX = rect.minX
          }

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
        let inputRange = tabs.indices.compactMap { return CGFloat($0) }
        let outputRange = tabs.compactMap { return $0.size.width }
        let outputPositionRange = tabs.compactMap { return $0.minX }

        let indicatorWidth = progress.interpolate(inputRange: inputRange, outputRange: outputRange)
        let indicatorPosition = progress.interpolate(
          inputRange: inputRange, outputRange: outputPositionRange)
        Rectangle()
          .fill(Color(uiColor: .brandedBlue))
          .frame(width: indicatorWidth, height: 1.5)
          .offset(x: indicatorPosition)
      }
    }
    .scrollIndicators(.hidden)
  }
}

#Preview {
  NotificationsTabView()
}
