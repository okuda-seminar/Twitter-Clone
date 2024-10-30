import SwiftUI
import UIKit

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/480
// - Implement Navigation from TimelineSettingsHomeScreenTabsViewController
//   to UserListsPageViewController and CommunitiesHomeViewController.
class TimelineSettingsHomeScreenTabsViewController: UIViewController {

  // MARK: - Private Props

  private enum LocalizedString {
    static let navigationBarTitle = String(localized: "Home screen tabs")
  }

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: TimelineSettingsHomeScreenTabsView())
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setUpNavigation()
  }

  // MARK: - Private API

  private func setUpSubviews() {
    view.addSubview(hostingController.view)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
    ])
  }

  private func setUpNavigation() {
    view.backgroundColor = .systemBackground

    navigationItem.title = LocalizedString.navigationBarTitle
    navigationItem.backButtonDisplayMode = .minimal
  }
}

// MARK: - View

struct TimelineSettingsHomeScreenTabsView: View {

  private enum LocalizedString {
    static let headerText = String(localized: "Nothing here yet")
    static let subheaderText = String(
      localized: "Try pinning a List or Community to have easier access to your favorite content.")

    // Localized keys for highlighting specific words in the subheader text.
    static let subheaderListKey = String(localized: "List")
    static let subheaderCommunityKey = String(localized: "Community")
  }

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/481
  // - Enable Tap Detection for "List" and "Community" in TimelineSettingsHomeScreenTabsView.

  /// It might be necessary to implement a different method here that is not "AttributedString" to resolve the above issue.
  private func styledSubheaderText() -> AttributedString {
    var attributedText = AttributedString(LocalizedString.subheaderText)

    if let range = attributedText.range(of: LocalizedString.subheaderListKey) {
      attributedText[range].foregroundColor = .black
    }

    if let range = attributedText.range(of: LocalizedString.subheaderCommunityKey) {
      attributedText[range].foregroundColor = .black
    }

    return attributedText
  }

  var body: some View {
    VStack(alignment: .leading) {
      Header()
      Subheader()

      Spacer()
    }
    .padding(.horizontal)
  }

  @ViewBuilder
  private func Header() -> some View {
    Text(LocalizedString.headerText)
      .font(.title)
      .fontWeight(.heavy)
      .padding()
  }

  @ViewBuilder
  private func Subheader() -> some View {
    Text(styledSubheaderText())
      .font(.body)
      .foregroundStyle(.gray)
      .padding(.horizontal)
  }
}

#Preview {
  TimelineSettingsHomeScreenTabsView()
}
