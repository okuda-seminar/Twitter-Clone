import SwiftUI
import UIKit

class NotificationsViewController: ViewControllerWithUserIconButton {

  private enum LayoutConstant {
    static let edgePadding = 16.0
  }

  private enum LocalizedString {
    static let title = String(localized: "Notifications")
  }

  private lazy var profileIconButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(showSideMenu))
    button.tintColor = .black
    button.image = UIImage(systemName: "person.circle.fill")
    return button
  }()

  private lazy var exploreSettingsEntryPointButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(presentExploreSettings))
    button.tintColor = .black
    button.image = UIImage(systemName: "gear")
    return button
  }()

  private let newPostEntryPointButtonController = NewPostEntrypointButtonController()

  private lazy var tabViewController: UIHostingController = {
    let controller = UIHostingController(rootView: NotificationsTabView(delegate: self))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground

    view.addSubview(tabViewController.view)
    view.addSubview(newPostEntryPointButtonController.view)

    addChild(newPostEntryPointButtonController)
    newPostEntryPointButtonController.didMove(toParent: self)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      tabViewController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      tabViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tabViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tabViewController.view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),

      newPostEntryPointButtonController.view.bottomAnchor.constraint(
        equalTo: layoutGuide.bottomAnchor, constant: -LayoutConstant.edgePadding),
      newPostEntryPointButtonController.view.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),
    ])

    // set up the navigation header
    navigationController?.navigationBar.tintColor = .black
    navigationItem.backButtonDisplayMode = .minimal
    navigationItem.title = LocalizedString.title
    navigationItem.leftBarButtonItems = [profileIconButton]
    navigationItem.rightBarButtonItems = [exploreSettingsEntryPointButton]
  }

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

extension NotificationsViewController: NotificationsTabViewDelegate {
  func didSelectNotification(_ notificationModel: NotificationModel) {
    guard let navigationController else { return }
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/249 - Replace fake tweet models.
    let postModel = createFakePostModel()
    navigationController.pushViewController(
      PostDetailViewController(postModel: postModel), animated: true)
  }

  func didTapSubscribeButton() {
    guard let navigationController else { return }
    navigationController.pushViewController(SubscribeOptionsViewController(), animated: true)
  }
}
