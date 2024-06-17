import SwiftUI
import UIKit

class MessagesSettingsHomeViewController: SettingsViewController {
  private enum LocalizedString {
    static let title = String(localized: "Messages settings")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    let hostingController = UIHostingController(rootView: MessagesSettingsHomeView())
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

struct MessagesSettingsHomeView: View {
  @Environment(\.dismiss) private var dismiss

  @State private var isNoOneOptionEnabled = true
  @State private var isVerifiedUsersOptionEnabled = false
  @State private var isEveryoneOptionEnabled = false
  @State private var isMediaEnabled = true

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
        MessagesSettingsHomeMessageRequestAccessControlSectionView(
          isNoOneOptionEnabled: $isNoOneOptionEnabled,
          isVerifiedUsersOptionEnabled: $isVerifiedUsersOptionEnabled,
          isEveryoneOptionEnabled: $isEveryoneOptionEnabled)

        Divider()

        MessagesSettingsHomeEnableCallingSectionView(isEnabled: $isMediaEnabled)

        MessagesSettingsHomeCallingAccessControlSectionView(
          isAddressBookEnabled: $isAddressBookEnabled, isFollowEnabled: $isFollowEnabled,
          isVerifiedUsersEnabled: $isVerifiedUsersEnabled, isEveryoneEnabled: $isEveryoneEnabled)

        MessagesSettingsHomeRelayCallsControlSectionView(isEnabled: $isRelayCallsEnabled)

        Divider()

        MessagesSettingsHomeMessageFilteringSectionView(isEnabled: $isFilterQualityEnabled)

        MessagesSettingsHomeReadReceiptsSectionView(isEnabled: $isReadReceiptsEnabled)

        MessagesSettingsHomeDeviceAndNotificationControlSectionView()

      }
    }
  }
}

#Preview {
  MessagesSettingsHomeView()
}
