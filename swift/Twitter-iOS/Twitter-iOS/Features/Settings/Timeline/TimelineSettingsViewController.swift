import SwiftUI
import UIKit

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/523
// - Fix Bug Where UINavigationBar Does Not Appear in TimelineSettingsViewController.

class TimelineSettingsViewController: UIViewController {

  // MARK: - Private Props

  private enum LocalizedString {
    static let navigationBarTitle = String(localized: "Timeline")
  }

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: TimelineSettingsView(delegate: self))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = LocalizedString.navigationBarTitle
    label.font = .preferredFont(forTextStyle: .headline)
    return label
  }()

  private let subtitleLabel: UILabel = {
    let label = UILabel()
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/464
    // - Enable Real Username Display in subtitleLabel in Settings View Controllers.

    /// This is a placeholder username that does not need to be wrapped in LocalizedString.
    /// It should be replaced with the real username variable in the future.
    label.text = "@userName"
    label.font = .preferredFont(forTextStyle: .footnote)
    label.textColor = .gray
    return label
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
    let titleStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
    titleStackView.axis = .vertical
    titleStackView.alignment = .center

    navigationItem.backButtonDisplayMode = .minimal
    navigationItem.titleView = titleStackView
    navigationItem.leftBarButtonItems = []
    navigationController?.navigationBar.backgroundColor = .systemBackground
  }
}

// MARK: - Delegate

extension TimelineSettingsViewController: TimelineSettingsViewDelegate {
  func navigationButtonDidReceiveTap() {
    navigationController?.pushViewController(
      TimelineSettingsHomeScreenTabsViewController(), animated: true)
  }
}

// MARK: - View

struct TimelineSettingsView: View {
  public weak var delegate: TimelineSettingsViewDelegate?

  private enum LocalizedString {
    static let navigationButtonTitleText = String(localized: "Home screen tabs")
    static let navigationButtonDescriptionText = String(
      localized: "Reorder your list and community tabs on the home screen")

  }

  var body: some View {
    VStack(alignment: .leading) {
      NavigationButton()
      NavigationButtonDescriptionText()

      Spacer()
    }
    .padding(.horizontal)
  }

  @ViewBuilder
  private func NavigationButton() -> some View {
    Button {
      delegate?.navigationButtonDidReceiveTap()
    } label: {
      HStack {
        Text(LocalizedString.navigationButtonTitleText)
          .fontWeight(.medium)
          .foregroundStyle(.black)

        Spacer()

        Image(systemName: "chevron.right")
          .foregroundStyle(.gray)
      }
      .padding(.vertical)
    }
  }

  @ViewBuilder
  private func NavigationButtonDescriptionText() -> some View {
    Text(LocalizedString.navigationButtonDescriptionText)
      .font(.body)
      .foregroundStyle(.gray)
  }
}

protocol TimelineSettingsViewDelegate: AnyObject {
  func navigationButtonDidReceiveTap()
}

#Preview {
  TimelineSettingsView()
}
