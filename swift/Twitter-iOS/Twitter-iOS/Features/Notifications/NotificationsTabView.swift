import SwiftUI

struct NotificationsTabView: View {
  public weak var delegate: NotificationsTabViewDelegate?

  @State private var tabs: [NotificationsTabModel] = [
    .init(id: .all),
    .init(id: .verified),
    .init(id: .mentions),
  ]
  @State private var activeTab: NotificationsTabModel.Tab = .all
  @State private var tabScrollState: NotificationsTabModel.Tab?
  @State private var progress: CGFloat = .zero
  @State private var selectedNotificationModel: NotificationModel?
  @State private var openSubscriptionOptionsPage: Bool = false

  var body: some View {
    VStack(spacing: 0) {
      TabBar()
      Tabs()
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
            let modifiedTabWidth =
              max(40, rect.size.width) + 20
            tab.size = CGSizeMake(modifiedTabWidth, rect.size.height)
            tab.minX = (rect.minX + rect.maxX - modifiedTabWidth) / 2
          }
          Spacer()
        }
      }
    }
    .overlay(alignment: .bottom) {
      TabBarProgressLine()
    }
    .scrollIndicators(.hidden)
  }

  @ViewBuilder
  private func TabBarProgressLine() -> some View {
    ZStack(alignment: .leading) {
      Divider()

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

  @ViewBuilder
  private func Tabs() -> some View {
    GeometryReader { geoProxy in
      let size = geoProxy.size

      ScrollView(.horizontal) {
        LazyHStack(spacing: 0) {
          ForEach(tabs) { tab in
            switch tab.id {
            case .all:
              NotificationsAllTabView(selectedNotificationModel: $selectedNotificationModel)
                .frame(width: size.width)
                .onChange(of: selectedNotificationModel) { _, selectedNotificationModel in
                  guard let selectedNotificationModel else { return }
                  delegate?.didSelectNotification(selectedNotificationModel)
                }
            case .verified:
              NotificationsVerifiedTabView(openSubscribeOptionsPage: $openSubscriptionOptionsPage)
                .frame(width: size.width)
            case .mentions:
              NotificationsMentionsTabView()
                .frame(width: size.width)
            }
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
      .onChange(of: openSubscriptionOptionsPage) {
        delegate?.didTapSubscribeButton()
      }
    }
  }
}

protocol NotificationsTabViewDelegate: AnyObject {
  func didSelectNotification(_ notificationModel: NotificationModel)
  func didTapSubscribeButton()
}

#Preview {
  NotificationsTabView()
}
