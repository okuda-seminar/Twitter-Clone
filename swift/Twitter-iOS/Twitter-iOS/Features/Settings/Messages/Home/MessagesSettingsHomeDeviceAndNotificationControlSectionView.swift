import SwiftUI

struct MessagesSettingsHomeDeviceAndNotificationControlSectionView: View {
  private enum LocalizedString {
    static let manageDevicesTitle = String(localized: "Manage encrypted devices")
    static let pushNotificationsTitle = String(localized: "Push notifications")
  }

  var body: some View {
    VStack {
      MessagesStackItem(title: LocalizedString.manageDevicesTitle)

      MessagesStackItem(title: LocalizedString.pushNotificationsTitle)
    }
    .padding(.horizontal)
  }
}

struct MessagesStackItem: View {
  public var title: String

  var body: some View {
    Button(
      action: {},
      label: {
        HStack(alignment: .center) {
          Text(title)
          Spacer()

          Image(systemName: "chevron.right")
            .foregroundStyle(Color(uiColor: .lightGray))
        }
      }
    )
    .buttonStyle(.plain)
    .padding(.top)
  }
}

#Preview {
  MessagesSettingsHomeDeviceAndNotificationControlSectionView()
}
