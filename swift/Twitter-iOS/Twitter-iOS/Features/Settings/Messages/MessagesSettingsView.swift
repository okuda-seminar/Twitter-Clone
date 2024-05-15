import SwiftUI

struct MessagesSettingsView: View {
  private enum LocalizedString {
    static let headerTitle = String(localized: "Messages settings")
    static let dismissButtonTitle = String(localized: "Done")

    static let headlineText = String(localized: "Allow message requests from:")
    static let headlineCaption = String(
      localized: "People you follow will always be able to message you.")

    static let noOneOptionTitle = String(localized: "No one")
    static let verifiedUsersOptionTitle = String(localized: "Verified users")
    static let everyoneOptionTitle = String(localized: "Everyone")

    static let mediaOptionTitle = String(localized: "Enable audio and video calling")
    static let mediaOptionCaption = String(
      localized:
        "Take messaging to the next level with audio and video calls. When enabled you can select who you're comfortable using it with."
    )

    static let addressBookOption = String(localized: "People in your address book")
  }

  @State private var isMediaEnabled = true
  @State private var isNoOneOptionEnabled = true
  @State private var isAddressBookEnabled = true

  var body: some View {
    VStack {
      HStack {
        Button(
          action: {

          },
          label: {
            Image(systemName: "arrow.left")
              .foregroundStyle(.black)
          })
        Spacer()
        Text(LocalizedString.headerTitle)
        Spacer()
        Button(
          action: {},
          label: {
            Text(LocalizedString.dismissButtonTitle)
              .foregroundStyle(.black)
          })
      }

      ScrollView {
        HStack {
          Text(LocalizedString.headlineText)
          Spacer()
        }

        HStack {
          Text(LocalizedString.headlineCaption)
            .font(.caption2)
          Spacer()
        }

        VStack {
          Toggle(
            isOn: $isNoOneOptionEnabled,
            label: {
              Text(LocalizedString.noOneOptionTitle)
              Spacer()
            })
          Toggle(
            isOn: $isMediaEnabled,
            label: {
              Text(LocalizedString.verifiedUsersOptionTitle)
              Spacer()
            })
          Toggle(
            isOn: $isMediaEnabled,
            label: {
              Text(LocalizedString.everyoneOptionTitle)
              Spacer()
            })
        }

        Divider()

        Toggle(
          isOn: $isMediaEnabled,
          label: {
            Text(LocalizedString.mediaOptionTitle)
            Spacer()
          })
        Text(LocalizedString.mediaOptionCaption)
          .font(.caption2)

        Toggle(
          isOn: $isAddressBookEnabled,
          label: {
            Text(LocalizedString.addressBookOption)
            Spacer()
          })
      }
    }
    .padding()
  }
}

#Preview{
  MessagesSettingsView()
}
