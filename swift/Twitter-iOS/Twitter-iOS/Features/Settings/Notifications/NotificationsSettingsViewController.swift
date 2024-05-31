import SwiftUI
import UIKit

class NotificationsSettingsViewController: SettingsViewController {
  private enum LocalizedString {
    static let title = String(localized: "Notifications")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setSubviews()
  }

  private func setSubviews() {
    let hostingController = UIHostingController(rootView: NotificationsSettingsView())
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

struct NotificationsSettingsView: View {
  @Environment(\.dismiss) private var dismiss

  private enum LocalizedString {
    static let headerCaption = String(
      localized:
        "Select the kinds of notifications you get about your activities, interests, and recommendations."
    )

    static let filtersTitle = String(localized: "Filters")
    static let filtersCaption = String(
      localized: "Choose the notifications you'd like to see - and those you don't.")

    static let preferencesTitle = String(localized: "Preferences")
    static let preferencesCaption = String(
      localized: "Select your preferences by notification type.")
  }

  var body: some View {
    ScrollView {
      VStack {
        NotificationsStackItem(
          icon: Image(systemName: "line.3.horizontal.decrease.circle"),
          title: LocalizedString.filtersTitle, caption: LocalizedString.filtersCaption)

        NotificationsStackItem(
          icon: Image(systemName: "airport.express"), title: LocalizedString.preferencesTitle,
          caption: LocalizedString.preferencesCaption)
      }
    }
  }
}

/// Probably we can create a shared stack item.
struct NotificationsStackItem: View {
  public var icon: Image
  public var title: String
  public var caption: String

  var body: some View {
    Button(
      action: {},
      label: {
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
    )
    .buttonStyle(.plain)
  }
}

#Preview {
  NotificationsSettingsView()
}
