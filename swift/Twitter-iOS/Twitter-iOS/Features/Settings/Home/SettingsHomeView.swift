import SwiftUI

struct SettingsHomeView: View {
  @Environment(\.dismiss) private var dismiss

  private enum LocalizedString {
    static let navigationTitle = String(localized: "Settings")
    static let dismissButtonTitle = String(localized: "Done")

    static let yourAccountTitle = String(localized: "Your account")
    static let yourAccountCaption = String(
      localized:
        "See information about your account, download an archive of your data, or learn about your account deactivation options."
    )

    static let notificationsTitle = String(localized: "Notifications")
    static let notificationsCaption = String(
      localized:
        "Select the kinds of notifications you get about your activities, interests, and recommendations."
    )
  }

  var body: some View {
    NavigationStack {
      ScrollView {
        VStack {
          SettingsHomeStackItem(
            icon: Image(systemName: "person"),
            title: LocalizedString.yourAccountTitle,
            caption: LocalizedString.yourAccountCaption)

          NavigationLink(destination: NotificationsSettingsView()) {
            SettingsHomeStackItem(
              icon: Image(systemName: "bell"),
              title: LocalizedString.notificationsTitle,
              caption: LocalizedString.notificationsCaption)
          }
        }
      }
      .navigationTitle(LocalizedString.navigationTitle)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button(
            action: {
              dismiss()
            },
            label: {
              Text(LocalizedString.dismissButtonTitle)
                .underline()
                .foregroundStyle(.black)
            })
        }
      }
    }
  }
}

struct SettingsHomeStackItem: View {
  public var icon: Image?
  public var title: String
  public var caption: String

  var body: some View {

    HStack(alignment: .center) {
      icon
        .foregroundStyle(Color(uiColor: .gray))

      VStack(alignment: .leading) {
        Text(title)
          .foregroundStyle(.black)
          .font(.title3)
        Text(caption)
          .foregroundStyle(Color(uiColor: .brandedLightGrayText))
          .font(.caption2)
          .multilineTextAlignment(.leading)
      }
      .padding()

      Image(systemName: "chevron.right")
        .foregroundStyle(Color(uiColor: .lightGray))
    }
    .padding()

  }
}

#Preview{
  SettingsHomeView()
}
