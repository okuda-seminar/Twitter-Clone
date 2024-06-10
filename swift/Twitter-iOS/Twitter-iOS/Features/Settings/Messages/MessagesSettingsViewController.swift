import SwiftUI
import UIKit

class MessagesSettingsViewController: SettingsViewController {
  private enum LocalizedString {
    static let title = String(localized: "Messages settings")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    let hostingController = UIHostingController(rootView: MessagesSettingsView())
    addChild(hostingController)
    hostingController.didMove(toParent: self)
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(hostingController.view)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
    ])

    // set up navigation
    navigationItem.title = LocalizedString.title
    navigationItem.leftBarButtonItems = []
    navigationController?.navigationBar.backgroundColor = .systemBackground
  }

}

struct MessagesSettingsView: View {
  @Environment(\.dismiss) private var dismiss

  private enum LayoutConstant {
    static let headlinePadding: CGFloat = 4.0
    static let audioTextPadding: CGFloat = 10.0
    static let audioCaptionPadding: CGFloat = 8.0
  }

  private enum LocalizedString {
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

    static let allowAudioText = String(localized: "Allow audio and video calls from:")

    static let allowAudioCaption = String(
      localized:
        "To reduce unwanted calls, you'll need to have messaged an account at least once before they're able to call you."
    )

    static let addressBookOption = String(localized: "People in your address book")

    static let followOption = String(localized: "People you follow")

    static let verifiedUsersOption = String(localized: "Verified users")

    static let everyoneOption = String(localized: "Everyone")

    static let relayCallsOptionTitle = String(localized: "Always relay calls")
    static let relayCallsOptionCaption = String(
      localized:
        "Enable this setting to avoid revealing your IP address to your contact during the call. This will reduce call quality."
    )

    static let filterQualityOptionTitle = String(localized: "Filter low-quality messages")

    static let filterQualityOptionCaption = String(
      localized:
        "Hide message requests that have been detected as being potentially spam or low-quality. These will be sent to a separate inbox located at the bottom of your message requests. You can still access them if you want."
    )

    static let readReceiptsOptionTitle = String(localized: "Show read receipts")

    static let readReceiptsOptionCaption = String(
      localized:
        "Let people you're messaging with know when you've seen their messages.\n\nRead receipts are not shown on message requests."
    )

    static let manageDevicesTitle = String(localized: "Manage encrypted devices")

    static let pushNotificationsTitle = String(localized: "Push notifications")

  }

  @State private var isMediaEnabled = true
  @State private var isNoOneOptionEnabled = true
  @State private var isVerifiedUsersOptionEnabled = false
  @State private var isEveryoneOptionEnabled = false

  @State private var isAddressBookEnabled = true
  @State private var isFollowEnabled = false
  @State private var isVerifiedUsersEnabled = false
  @State private var isEveryoneEnabled = false

  @State private var isRelayCallsEnabled = false
  @State private var isFilterQualityEnabled = true
  @State private var isReadReceiptsEnabled = false

  var body: some View {
    VStack {
      ScrollView {
        HStack {
          Text(LocalizedString.headlineText)
            .fontWeight(.bold)
          Spacer()
        }

        TextWithLink(text: LocalizedString.headlineCaption)
          .padding(.top, LayoutConstant.headlinePadding)

        // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/273
        // - Add radio button function to checkbox.
        VStack {
          Checkbox(
            isOn: $isNoOneOptionEnabled, label: LocalizedString.noOneOptionTitle,
            style: .circleCheckboxStyle)

          Checkbox(
            isOn: $isVerifiedUsersOptionEnabled, label: LocalizedString.verifiedUsersOptionTitle,
            style: .circleCheckboxStyle)

          Checkbox(
            isOn: $isEveryoneOptionEnabled, label: LocalizedString.everyoneOptionTitle,
            style: .circleCheckboxStyle)
        }

        Divider()

        ToggleItemWithCaption(
          isEnabled: $isMediaEnabled, title: LocalizedString.mediaOptionTitle,
          caption: LocalizedString.mediaOptionCaption)

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

              Checkbox(
                isOn: $isEveryoneEnabled, label: LocalizedString.everyoneOption,
                style: .squareCheckboxStyle)
            }
          } else {
            VStack {
              Checkbox(
                isOn: $isAddressBookEnabled, label: LocalizedString.addressBookOption,
                style: .squareCheckboxStyle)

              Checkbox(
                isOn: $isFollowEnabled, label: LocalizedString.followOption,
                style: .squareCheckboxStyle)

              Checkbox(
                isOn: $isVerifiedUsersEnabled, label: LocalizedString.verifiedUsersOption,
                style: .squareCheckboxStyle)

              Checkbox(
                isOn: $isEveryoneEnabled, label: LocalizedString.everyoneOption,
                style: .squareCheckboxStyle)
            }
          }

        }

        ToggleItemWithCaption(
          isEnabled: $isRelayCallsEnabled, title: LocalizedString.relayCallsOptionTitle,
          caption: LocalizedString.relayCallsOptionCaption)

        Divider()

        ToggleItemWithCaption(
          isEnabled: $isFilterQualityEnabled, title: LocalizedString.filterQualityOptionTitle,
          caption: LocalizedString.filterQualityOptionCaption)

        ToggleItemWithCaption(
          isEnabled: $isReadReceiptsEnabled, title: LocalizedString.readReceiptsOptionTitle,
          caption: LocalizedString.readReceiptsOptionCaption)

        MessagesStackItem(title: LocalizedString.manageDevicesTitle)

        MessagesStackItem(title: LocalizedString.pushNotificationsTitle)

      }
    }
    .padding()
  }
}

struct Checkbox: View {
  private enum LayoutConstant {
    static let checkboxPadding: CGFloat = 5.0
  }

  @Binding var isOn: Bool
  var label: String
  var style: CheckboxStyle.Style

  var body: some View {
    Toggle(
      isOn: $isOn,
      label: {
        Text(label)
        Spacer()
      }
    )
    .toggleStyle(CheckboxStyle(style: style))
    .padding(.top, LayoutConstant.checkboxPadding)
    .animation(.default, value: UUID())
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

struct ToggleItemWithCaption: View {
  private enum LayoutConstant {
    static let toggleTrailingPadding: CGFloat = 2.0
    static let toggleTopPadding: CGFloat = 20.0
  }

  @Binding public var isEnabled: Bool
  public var title: String
  public var caption: String

  var body: some View {
    Toggle(
      isOn: $isEnabled,
      label: {
        Text(title)
        Spacer()
      }
    )
    .padding(.trailing, LayoutConstant.toggleTrailingPadding)
    .padding(.top, LayoutConstant.toggleTopPadding)

    TextWithLink(text: caption)
  }
}

struct TextWithLink: View {
  private enum LocalizedString {
    static let learnMoreText = String(localized: " Learn more")
  }

  public var text: String

  var body: some View {
    HStack {
      Text(text)
        .font(.caption2)
        .foregroundStyle(Color(.gray))
        + Text(LocalizedString.learnMoreText)
        .font(.caption2)
        .foregroundStyle(Color(.blue))

      Spacer()
    }
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
  MessagesSettingsView()
}
