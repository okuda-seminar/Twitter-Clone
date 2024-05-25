import SwiftUI

struct NotificationsAllTabView: View {
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
            userIcon: notificationModel.userIcon, userName: notificationModel.userName,
            caption: notificationModel.caption)
        }
      }
    }
  }
}

struct NotificationsAllTabCellView: View {
  public var userIcon: Image
  public var userName: String
  public var caption: String

  private enum LayoutConstant {
    static let userIconSize: CGFloat = 28.0
  }

  private enum LocalizedString {
    static let menuTitle = String(localized: "See less often")
  }

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        userIcon
          .resizable()
          .frame(width: LayoutConstant.userIconSize, height: LayoutConstant.userIconSize)
          .scaledToFit()
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
      Text(userName)
      Text(caption)
        .font(.caption)
        .foregroundStyle(.gray)
    }
    .padding()
  }
}

#Preview {
  NotificationsAllTabView()
}
