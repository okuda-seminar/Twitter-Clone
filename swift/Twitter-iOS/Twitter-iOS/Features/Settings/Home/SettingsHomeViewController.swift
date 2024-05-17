import SwiftUI
import UIKit

class SettingsHomeViewController: UIViewController {

  private enum LocalizedString {
    static let title = String(localized: "Settings")
  }

  override func viewDidLoad() {
    setSubviews()
  }

  private func setSubviews() {
    let hostingController = UIHostingController(rootView: SettingsHomeView(delegate: self))
    addChild(hostingController)
    hostingController.didMove(toParent: self)
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(hostingController.view)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
    ])

    // set up navigation
    navigationItem.backButtonDisplayMode = .minimal
    navigationItem.title = LocalizedString.title
    navigationItem.leftBarButtonItems = []
  }
}

extension SettingsHomeViewController: SettingsHomeViewDelegate {
  func pushNotificationsSettings() {
    navigationController?.pushViewController(NotificationsSettingsViewController(), animated: true)
  }
}

struct SettingsHomeView: View {
  @Environment(\.dismiss) private var dismiss

  public weak var delegate: SettingsHomeViewDelegate?

  private enum LocalizedString {
    static let navigationTitle = String(localized: "Settings")

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
    ScrollView {
      VStack {
        SettingsHomeStackItem(
          icon: Image(systemName: "person"),
          title: LocalizedString.yourAccountTitle,
          caption: LocalizedString.yourAccountCaption)

        SettingsHomeStackItem(
          icon: Image(systemName: "bell"),
          title: LocalizedString.notificationsTitle,
          caption: LocalizedString.notificationsCaption
        )
        .onTapGesture {
          delegate?.pushNotificationsSettings()
        }
      }
    }
  }
}

protocol SettingsHomeViewDelegate: AnyObject {
  func pushNotificationsSettings()
}

struct SettingsHomeStackItem: View {
  public var icon: Image
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
      Spacer()

      Image(systemName: "chevron.right")
        .foregroundStyle(Color(uiColor: .lightGray))
    }
    .padding()

  }
}

#Preview{
  SettingsHomeView()
}
