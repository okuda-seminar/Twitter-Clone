import SwiftUI

struct MessagesSettingsHomeCallingAccessControlSectionView: View {

  private enum LayoutConstant {
    static let audioTextPadding: CGFloat = 10.0
    static let audioCaptionPadding: CGFloat = 8.0
  }

  private enum LocalizedString {
    static let allowAudioText = String(localized: "Allow audio and video calls from:")
    static let allowAudioCaption = String(
      localized:
        "To reduce unwanted calls, you'll need to have messaged an account at least once before they're able to call you."
    )
    static let addressBookOption = String(localized: "People in your address book")
    static let followOption = String(localized: "People you follow")
    static let verifiedUsersOption = String(localized: "Verified users")
    static let everyoneOption = String(localized: "Everyone")
  }

  @Binding public var isAddressBookEnabled: Bool
  @Binding public var isFollowEnabled: Bool
  @Binding public var isVerifiedUsersEnabled: Bool
  @Binding public var isEveryoneEnabled: Bool

  var body: some View {
    VStack {
      HStack {
        Text(LocalizedString.allowAudioText)
        Spacer()
      }
      .padding(.top, LayoutConstant.audioTextPadding)

      HStack {
        Text(LocalizedString.allowAudioCaption)
          .font(.caption2)
          .foregroundStyle(Color(.gray))
        Spacer()
      }
      .padding(.vertical, LayoutConstant.audioCaptionPadding)

      ZStack {
        if isEveryoneEnabled {
          VStack {
            DummySquareCheckbox(label: LocalizedString.addressBookOption)

            DummySquareCheckbox(label: LocalizedString.followOption)

            DummySquareCheckbox(label: LocalizedString.verifiedUsersOption)

            SquareCheckbox(
              isOn: $isEveryoneEnabled, label: LocalizedString.everyoneOption)
          }
        } else {
          VStack {
            SquareCheckbox(
              isOn: $isAddressBookEnabled, label: LocalizedString.addressBookOption)

            SquareCheckbox(
              isOn: $isFollowEnabled, label: LocalizedString.followOption)

            SquareCheckbox(
              isOn: $isVerifiedUsersEnabled, label: LocalizedString.verifiedUsersOption)

            SquareCheckbox(
              isOn: $isEveryoneEnabled, label: LocalizedString.everyoneOption)
          }
        }
      }
    }
    .padding(.horizontal)
  }
}

struct DummySquareCheckbox: View {
  private enum LayoutConstant {
    static let checkboxPadding: CGFloat = 5.0
    static let fontSize: CGFloat = 28.0
    static let opacity: CGFloat = 0.5
  }

  var label: String

  var body: some View {
    HStack {
      Text(label)
        .foregroundStyle(.black)
        .opacity(LayoutConstant.opacity)

      Spacer()

      Image(systemName: "checkmark.square.fill")
        .foregroundColor(Color(uiColor: .brandedBlue))
        .opacity(LayoutConstant.opacity)
        .font(.system(size: LayoutConstant.fontSize, weight: .medium, design: .rounded))
    }
    .padding(.top, LayoutConstant.checkboxPadding)

  }
}

struct SquareCheckbox: View {
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
    .toggleStyle(CheckboxStyle(style: .squareCheckboxStyle))
    .padding(.top, LayoutConstant.checkboxPadding)
    .animation(.default, value: UUID())
  }
}

#Preview {
  MessagesSettingsHomeCallingAccessControlSectionView(
    isAddressBookEnabled: .constant(true), isFollowEnabled: .constant(false),
    isVerifiedUsersEnabled: .constant(false), isEveryoneEnabled: .constant(false))
}
