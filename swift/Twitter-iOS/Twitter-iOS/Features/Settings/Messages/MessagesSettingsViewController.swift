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

    static let addressBookOption = String(localized: "People in your address book")
  }

  @State private var isMediaEnabled = true
  @State private var isNoOneOptionEnabled = true
  @State private var isVerifiedUsersOptionEnabled = false
  @State private var isEveryOneOptionEnabled = false
  @State private var isAddressBookEnabled = true

  var body: some View {
    VStack {
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
            }
          )
          .toggleStyle(CheckboxStyle())
          Toggle(
            isOn: $isVerifiedUsersOptionEnabled,
            label: {
              Text(LocalizedString.verifiedUsersOptionTitle)
              Spacer()
            }
          )
          .toggleStyle(CheckboxStyle())
          Toggle(
            isOn: $isEveryOneOptionEnabled,
            label: {
              Text(LocalizedString.everyoneOptionTitle)
              Spacer()
            }
          )
          .toggleStyle(CheckboxStyle())
        }

        Divider()

        Toggle(
          isOn: $isMediaEnabled,
          label: {
            Text(LocalizedString.mediaOptionTitle)
            Spacer()
          }
        )
        .padding(.trailing, 2)

        Text(LocalizedString.mediaOptionCaption)
          .font(.caption2)

        Toggle(
          isOn: $isAddressBookEnabled,
          label: {
            Text(LocalizedString.addressBookOption)
            Spacer()
          }
        )
        .padding(.trailing, 2)
      }
    }
    .padding()
  }
}

#Preview {
  MessagesSettingsView()
}
