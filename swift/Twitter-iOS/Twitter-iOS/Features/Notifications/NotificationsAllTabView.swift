import SwiftUI

struct NotificationsAllTabView: View {
  @Binding var selectedNotificationModel: NotificationModel?

  var notificationModels: [NotificationModel] = {
    var models: [NotificationModel] = []
    for _ in 0..<5 {
      models.append(createFakeNotificationModel())
    }
    return models
  }()

  var body: some View {
    ScrollView(.vertical) {
      LazyVStack {
        ForEach(notificationModels) { notificationModel in
          NotificationsAllTabCellView(
            selectedNotificationModel: $selectedNotificationModel,
            notificationModel: notificationModel)
        }
      }
    }
  }
}

struct NotificationsAllTabCellView: View {
  @Binding var selectedNotificationModel: NotificationModel?

  public var notificationModel: NotificationModel

  private enum LayoutConstant {
    static let userIconSize: CGFloat = 28.0
  }

  private enum LocalizedString {
    static let menuTitle = String(localized: "See less often")
  }

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        notificationModel.userIcon
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.userIconSize, height: LayoutConstant.userIconSize)
        Spacer()
        Menu {
          Button(
            action: {
              print("See less often is tapped.")
            },
            label: {
              Label(LocalizedString.menuTitle, systemImage: "hand.thumbsdown")
            })
        } label: {
          Button(
            action: {
            },
            label: {
              Image(systemName: "ellipsis")
            }
          )
          .buttonStyle(.plain)
        }
        .foregroundStyle(.primary)
      }
      Text(notificationModel.userName)
      Text(notificationModel.caption)
        .font(.caption)
        .foregroundStyle(.gray)
    }
    .padding()
    .onTapGesture {
      selectedNotificationModel = notificationModel
    }
  }
}

#Preview {
  NotificationsAllTabView(selectedNotificationModel: .constant(nil))
}
