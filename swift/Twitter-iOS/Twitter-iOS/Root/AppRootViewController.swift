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

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/658 - Polish Sign up navigation.
    showSignUpViewIfNeeded()
  }

  // MARK: - View Lifecycle

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

  // MARK: - Auth

  private func showSignUpViewIfNeeded() {
    if !injectAuthService().isAuthenticated {
      let signUpViewController = SignUpViewController()
      signUpViewController.modalPresentationStyle = .fullScreen
      present(signUpViewController, animated: false)
    }
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

  func addAcountsButtonDidReceiveTap() {
    let accountVC = AccountSelectionViewController()

    // 1. Set the modal presentation style to allow UISheetPresentationController
    accountVC.modalPresentationStyle = .pageSheet

    // 2. Configure the sheet presentation controller
    if let sheet = accountVC.sheetPresentationController {
      // Use custom detents for a specific small height, or medium for a standard one.
      // Based on your image, a custom detent or `.medium()` might be appropriate.

      let customDetent = UISheetPresentationController.Detent.custom(identifier: .init("small")) {
        context in
        // Return a specific height value for the sheet,
        // for example, 300 points, or calculate it based on content.
        // You'll need to fine-tune this value.
        return 300
      }

      sheet.detents = [customDetent, .medium()]  // Allows for a custom size and potentially medium size

      // To remove the default grabber line:
      sheet.prefersGrabberVisible = false

      // To only show the content without the dimmed background (if desired, though usually dimming is preferred)
      // sheet.largestUndimmedDetentIdentifier = customDetent.identifier

      // Optional: Set a corner radius
      sheet.preferredCornerRadius = 15.0
    }

    sideMenuViewController.present(accountVC, animated: true, completion: nil)
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
