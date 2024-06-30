import SwiftUI

struct MessagesSettingsHomeDeviceAndNotificationControlSectionView: View {

  @Binding public var showPushNotificationsSettings: Bool

  private enum LocalizedString {
    static let manageDevicesTitle = String(localized: "Manage encrypted devices")
    static let pushNotificationsTitle = String(localized: "Push notifications")
  }

  var body: some View {
    VStack {
      MessagesStackItem(showSettings: .constant(false), title: LocalizedString.manageDevicesTitle)

      MessagesStackItem(
        showSettings: $showPushNotificationsSettings, title: LocalizedString.pushNotificationsTitle)
    }
    .padding(.horizontal)
  }
}

struct MessagesStackItem: View {

  @Binding public var showSettings: Bool
  public var title: String

  var body: some View {
    Button(
      action: {
        showSettings.toggle()
      },
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
  MessagesSettingsHomeDeviceAndNotificationControlSectionView(
    showPushNotificationsSettings: .constant(false))
}
