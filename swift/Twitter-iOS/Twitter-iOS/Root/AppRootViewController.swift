import SwiftUI
import UIKit

/// The root view controller of the app, responsible for managing the side menu and main content navigation.
class AppRootViewController: UIViewController {

  // MARK: - Private Props

  /// The controller responsible for the side menu transition animation.
  private let sideMenuTransitionController = SideMenuTransitionController()

  /// The `UITabBarController` that manages the selected tab's view.
  private lazy var mainRootViewController: MainRootViewController = {
    let viewController = MainRootViewController.sharedInstance
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(viewController)
    viewController.didMove(toParent: self)
    return viewController
  }()

  /// The view controller responsible for displaying the side menu.
  private lazy var sideMenuViewController: UIHostingController = {
    let fakeUser = injectCurrentUser()
    let viewController = UIHostingController(
      rootView: SideMenuView(
        userName: fakeUser.userName, numOfFollowing: fakeUser.numOfFollowers,
        numOfFollowers: fakeUser.numOfFollowers, delegate: self))
    return viewController
  }()

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
    setUpSideMenuTransition()
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

  private func setUpSideMenuTransition() {
    sideMenuTransitionController.setUpViewControllersForSideMenuTransition(
      parentVC: self, mainVC: mainRootViewController, sideMenuVC: sideMenuViewController)
  }

  // MARK: - Public API

  public func hideSideMenu() {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/409
    // - Enable Smoother Transitions from SideMenu to Other Views.
    sideMenuTransitionController.dismissSideMenu()
  }

  public func showSideMenu() {
    sideMenuTransitionController.presentSideMenu()
  }
}

// MARK: - Delegate

extension AppRootViewController: SideMenuViewDelegate {

  /// Pushes the user profile view controller into the navigation controller when the profile button is tapped in the side menu.
  func userProfileDidReceiveTap() {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    let userProfileViewController = UserProfileViewController(userModel: injectCurrentUser())
    selectedViewController.pushViewController(userProfileViewController, animated: true)
  }

  /// Pushes the user bookmarks view controller into the navigation controller when the bookmarks button is tapped in the side menu.
  func bookmarksDidReceiveTap() {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    let userBookmarksPageViewController = UserBookmarksPageViewController()
    selectedViewController.pushViewController(userBookmarksPageViewController, animated: true)
  }

  /// Pushes the jobs view controller into the navigation controller when the jobs button is tapped in the side menu.
  func jobsDidReceiveTap() {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    selectedViewController.pushViewController(JobsViewController(), animated: true)
  }

  /// Pushes the user lists page view controller into the navigation controller when the lists button is tapped in the side menu.
  func listsDidReceiveTap() {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    selectedViewController.pushViewController(UserListsPageViewController(), animated: true)
  }

  /// Pushes the user follower requests page view controller into the navigation controller when the follower requests button is tapped in the side menu.
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

  /// Pushes the settings view controller into the navigation controller when the settings and privacy button is tapped in the side menu.
  func settingsAndPrivacyDidReceiveTap() {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    let settingsViewController = SettingsHomeViewController()
    selectedViewController.pushViewController(settingsViewController, animated: true)
  }

  /// Pushes the user follow relations view controller into the navigation controller when the follow relations buttons are tapped in the side menu.
  /// - Parameter userName: The username of the current user of the app.
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

/// The view controller containing a user icon button that allows users to open the side menu by tapping the button.
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
