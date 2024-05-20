import SwiftUI
import UIKit

class NotificationsViewController: ViewControllerWithUserIconButton {

  private enum LayoutConstant {
    static let edgePadding = 16.0
  }

  private enum LocalizedString {
    static let title = String(localized: "Notifications")
  }

  private let headerTabSelectionView: NotificationsTabSelectionView = {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/138 - Replace custom home header view with Apple's navigation bar items.
    let view = NotificationsTabSelectionView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var profileIconButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(slideInSideMenu))
    button.tintColor = .black
    button.image = UIImage(systemName: "person.circle.fill")
    button.action = #selector(showSideMenu)
    button.target = self
    return button
  }()

  private lazy var exploreSettingsEntryPointButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(presentExploreSettings))
    button.tintColor = .black
    button.image = UIImage(systemName: "gear")
    return button
  }()

  private lazy var selectedButton: UIButton = headerTabSelectionView.tabButtons[0] {
    didSet {
      guard selectedButton != oldValue else { return }
      oldValue.isSelected = false
      selectedButton.isSelected = true
    }
  }

  private let newTweetEntryPointButtonController = NewTweetEntrypointButtonController()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    view.addSubview(headerTabSelectionView)
    view.addSubview(newTweetEntryPointButtonController.view)

    addChild(newTweetEntryPointButtonController)
    newTweetEntryPointButtonController.didMove(toParent: self)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      headerTabSelectionView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      headerTabSelectionView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      headerTabSelectionView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),

      newTweetEntryPointButtonController.view.bottomAnchor.constraint(
        equalTo: layoutGuide.bottomAnchor, constant: -LayoutConstant.edgePadding),
      newTweetEntryPointButtonController.view.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),
    ])

    // set up the navigation header
    navigationController?.navigationBar.tintColor = .black
    navigationItem.backButtonDisplayMode = .minimal
    navigationItem.title = LocalizedString.title
    navigationItem.leftBarButtonItems = [profileIconButton]
    navigationItem.rightBarButtonItems = [exploreSettingsEntryPointButton]

    headerTabSelectionView.delegate = self
  }

  @objc
  private func slideInSideMenu() {}

  @objc
  private func presentExploreSettings() {
    let settingsHomeViewController = SettingsHomeViewController()
    let presentingViewController = UINavigationController(
      rootViewController: settingsHomeViewController)
    let backButtonImage = UIImage(systemName: "arrow.left")
    presentingViewController.navigationBar.backIndicatorImage = backButtonImage
    presentingViewController.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    presentingViewController.navigationBar.tintColor = .black

    settingsHomeViewController.navigationItem.backButtonDisplayMode = .minimal
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/177
    // - Remove direct initialization of NotificationsSettingsViewController
    presentingViewController.pushViewController(
      NotificationsSettingsViewController(), animated: false)
    presentingViewController.modalPresentationStyle = .overFullScreen
    present(presentingViewController, animated: true)
  }
}

extension NotificationsViewController: NotificationsTabSelectionViewDelegate {
  func didTapTabButton(_ button: UIButton) {
    selectedButton = button
  }
}
