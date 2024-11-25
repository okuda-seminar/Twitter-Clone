import SwiftUI
import UIKit

class AppRootViewController: UIViewController {

  // MARK: - Private Props

  private let sideMenuTransitionController = SideMenuTransitionController()

  private lazy var mainRootViewController: MainRootViewController = {
    let viewController = MainRootViewController.sharedInstance
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(viewController)
    viewController.didMove(toParent: self)
    return viewController
  }()

  private lazy var sideMenuViewController: UIHostingController = {
    let fakeUser = injectCurrentUser()
    let viewController = UIHostingController(
      rootView: SideMenuView(
        userName: fakeUser.userName, numOfFollowing: fakeUser.numOfFollowers,
        numOfFollowers: fakeUser.numOfFollowers, delegate: self))
    viewController.modalPresentationStyle = .custom
    viewController.transitioningDelegate = sideMenuTransitionController
    return viewController
  }()

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  // MARK: - Private API

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground
    view.addSubview(mainRootViewController.view)

    NSLayoutConstraint.activate([
      mainRootViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      mainRootViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      mainRootViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
      mainRootViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }

  // MARK: - Public API

  public func hideSideMenu() {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/409
    // - Enable Smoother Transitions from SideMenu to Other Views.
    sideMenuViewController.dismiss(animated: true)
  }

  public func showSideMenu() {
    present(sideMenuViewController, animated: true)
  }
}

// MARK: - Delegate

extension AppRootViewController: SideMenuViewDelegate {

  func userProfileDidReceiveTap() {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    let userProfileViewController = UserProfileViewController(userModel: injectCurrentUser())
    selectedViewController.pushViewController(userProfileViewController, animated: true)
  }

  func bookmarksDidReceiveTap() {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    let userBookmarksPageViewController = UserBookmarksPageViewController()
    selectedViewController.pushViewController(userBookmarksPageViewController, animated: true)
  }

  func jobsDidReceiveTap() {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    selectedViewController.pushViewController(JobsViewController(), animated: true)
  }

  func listsDidReceiveTap() {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    selectedViewController.pushViewController(UserListsPageViewController(), animated: true)
  }

  func followerRequestsDidReceiveTap() {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    let userFollowerRequestsPageViewController = UserFollowerRequestsPageViewController()
    selectedViewController.pushViewController(
      userFollowerRequestsPageViewController, animated: true)
  }

  func settingsAndPrivacyDidReceiveTap() {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    let settingsViewController = SettingsHomeViewController()
    selectedViewController.pushViewController(settingsViewController, animated: true)
  }

  func userFollowRelationsButtonDidReceiveTap(userName: String) {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    let userFollowRelationsViewController = UserFollowRelationsViewController(userName: userName)
    selectedViewController.pushViewController(userFollowRelationsViewController, animated: true)
  }
}

class ViewControllerWithUserIconButton: UIViewController {

  private var rootViewController: UIViewController {
    var viewController = self as UIViewController
    while let parent = viewController.parent {
      viewController = parent
    }
    return viewController
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setUpNavigation()
  }

  private func setUpNavigation() {
    navigationItem.backButtonDisplayMode = .minimal

    guard let navigationController else { return }
    let backButtonImage = UIImage(systemName: "arrow.left")
    navigationController.navigationBar.backIndicatorImage = backButtonImage
    navigationController.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    navigationController.navigationBar.tintColor = .black
    navigationController.setNavigationBarHidden(false, animated: false)
  }

  @objc
  public func showSideMenu() {
    guard let rootViewController = self.rootViewController as? AppRootViewController else { return }
    rootViewController.showSideMenu()
  }
}
