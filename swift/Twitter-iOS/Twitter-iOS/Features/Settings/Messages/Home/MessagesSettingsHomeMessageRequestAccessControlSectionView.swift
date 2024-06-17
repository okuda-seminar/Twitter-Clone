import SwiftUI

struct MessagesSettingsHomeMessageRequestAccessControlSectionView: View {

  private enum LayoutConstant {
    static let headlinePadding: CGFloat = 4.0
  }

  private enum LocalizedString {
    static let headlineText = String(localized: "Allow message requests from:")
    static let headlineCaption = String(
      localized: "People you follow will always be able to message you.")
    static let learnMoreText = String(localized: " Learn more")

    static let noOneOptionTitle = String(localized: "No one")
    static let verifiedUsersOptionTitle = String(localized: "Verified users")
    static let everyoneOptionTitle = String(localized: "Everyone")
  }

  @Binding public var isNoOneOptionEnabled: Bool
  @Binding public var isVerifiedUsersOptionEnabled: Bool
  @Binding public var isEveryoneOptionEnabled: Bool

  var body: some View {
    VStack {
      HStack {
        Text(LocalizedString.headlineText)
          .fontWeight(.bold)
        Spacer()
      }

      HStack {
        Text(LocalizedString.headlineCaption)
          .font(.caption2)
          .foregroundStyle(Color(.gray))
          + Text(LocalizedString.learnMoreText)
          .font(.caption2)
          .foregroundStyle(Color(.blue))

        Spacer()
      }
      .padding(.top, LayoutConstant.headlinePadding)

      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/273
      // - Add radio button function to checkbox.
      VStack {
        CircleCheckbox(
          isOn: $isNoOneOptionEnabled, label: LocalizedString.noOneOptionTitle)

        CircleCheckbox(
          isOn: $isVerifiedUsersOptionEnabled, label: LocalizedString.verifiedUsersOptionTitle)

        CircleCheckbox(
          isOn: $isEveryoneOptionEnabled, label: LocalizedString.everyoneOptionTitle)
      }
    }
    .padding(.horizontal)
  }
}

struct CircleCheckbox: View {
  private enum LayoutConstant {
    static let checkboxPadding: CGFloat = 5.0
  }

  @Binding var isOn: Bool
  var label: String

  var body: some View {
    Toggle(
      isOn: $isOn,
      label: {
        Text(label)
        Spacer()
      }
    )
    .toggleStyle(CheckboxStyle(style: .circleCheckboxStyle))
    .padding(.top, LayoutConstant.checkboxPadding)
    .animation(.default, value: UUID())
  }
}

#Preview {
  MessagesSettingsHomeMessageRequestAccessControlSectionView(
    isNoOneOptionEnabled: .constant(true), isVerifiedUsersOptionEnabled: .constant(false),
    isEveryoneOptionEnabled: .constant(false))
}
