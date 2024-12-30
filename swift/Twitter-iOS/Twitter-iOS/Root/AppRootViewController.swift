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
  private lazy var sideMenuViewController: CustomSideMenuHostingController = {
    let fakeUser = injectCurrentUser()
    let viewController = CustomSideMenuHostingController(
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
  // Current Implementation
  func userProfileDidReceiveTap() async {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    //    try? await Task.sleep(nanoseconds: 1_000_000_000)
    let userProfileViewController = UserProfileViewController(userModel: injectCurrentUser())
    let start = Date()
    selectedViewController.pushViewController(userProfileViewController, animated: true) {
      let end = Date()
      let elapsedTime = end.timeIntervalSince(start)
      print("push view controller time: ", elapsedTime)
      print("push completed\n")
    }
  }

  // Hide Side Menu after Pushing VC
  //  func userProfileDidReceiveTap() {
  //    guard
  //      let selectedViewController = mainRootViewController.selectedViewController
  //        as? UINavigationController
  //    else { return }
  //    let userProfileViewController = UserProfileViewController(userModel: injectCurrentUser())
  //    let start = Date()
  //    selectedViewController.pushViewController(userProfileViewController, animated: true) {
  //      let end = Date()
  //      let elapsedTime = end.timeIntervalSince(start)
  //      print("push view controller time: ", elapsedTime)
  //      print("push completed\n")
  //    }
  //    hideSideMenu()
  //  }

  // Use Completion to hide side menu
  //    func userProfileDidReceiveTap() {
  //      guard
  //        let selectedViewController = mainRootViewController.selectedViewController
  //          as? UINavigationController
  //      else { return }
  //      let userProfileViewController = UserProfileViewController(userModel: injectCurrentUser())
  //      let start = Date()
  //      selectedViewController.pushViewController(userProfileViewController, animated: true) { [weak self] in
  //        let end = Date()
  //        let elapsedTime = end.timeIntervalSince(start)
  //        print("push view controller time: ", elapsedTime)
  //        print("push completed\n")
  //        self?.hideSideMenu()
  //      }
  //    }

  /// Pushes the user bookmarks view controller into the navigation controller when the bookmarks button is tapped in the side menu.
  func bookmarksDidReceiveTap() {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    let userBookmarksPageViewController = UserBookmarksPageViewController()
    let start = Date()
    selectedViewController.pushViewController(userBookmarksPageViewController, animated: true) {
      let end = Date()
      let elapsedTime = end.timeIntervalSince(start)
      print("push view controller time: ", elapsedTime)
      print("push completed\n")
    }
  }

  /// Pushes the jobs view controller into the navigation controller when the jobs button is tapped in the side menu.
  func jobsDidReceiveTap() {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    let start = Date()
    selectedViewController.pushViewController(JobsViewController(), animated: true) {
      let end = Date()
      let elapsedTime = end.timeIntervalSince(start)
      print("push view controller time: ", elapsedTime)
      print("push completed\n")
    }
  }

  /// Pushes the user lists page view controller into the navigation controller when the lists button is tapped in the side menu.
  func listsDidReceiveTap() {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    let start = Date()
    selectedViewController.pushViewController(UserListsPageViewController(), animated: true) {
      let end = Date()
      let elapsedTime = end.timeIntervalSince(start)
      print("push view controller time: ", elapsedTime)
      print("push completed\n")
    }
  }

  /// Pushes the user follower requests page view controller into the navigation controller when the follower requests button is tapped in the side menu.
  func followerRequestsDidReceiveTap() {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    let userFollowerRequestsPageViewController = UserFollowerRequestsPageViewController()
    let start = Date()
    selectedViewController.pushViewController(
      userFollowerRequestsPageViewController, animated: true
    ) {
      let end = Date()
      let elapsedTime = end.timeIntervalSince(start)
      print("push view controller time: ", elapsedTime)
      print("push completed\n")
    }
  }

  /// Pushes the settings view controller into the navigation controller when the settings and privacy button is tapped in the side menu.
  func settingsAndPrivacyDidReceiveTap() {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    let settingsViewController = SettingsHomeViewController()
    let start = Date()
    selectedViewController.pushViewController(settingsViewController, animated: true) {
      let end = Date()
      let elapsedTime = end.timeIntervalSince(start)
      print("push view controller time: ", elapsedTime)
      print("push completed\n")
    }
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
    let start = Date()
    selectedViewController.pushViewController(userFollowRelationsViewController, animated: true) {
      let end = Date()
      let elapsedTime = end.timeIntervalSince(start)
      print("push view controller time: ", elapsedTime)
      print("push completed\n")
    }
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

class CustomSideMenuHostingController: UIHostingController<SideMenuView> {
  private var timeWhenViewWillDisappear = Date()
  private var timeWhenViewDidDisappear = Date()

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("\(className) viewWillAppear")
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print("\(className) viewDidAppear")
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    timeWhenViewWillDisappear = Date()
    print("\(className) viewDidDisappear: 0s")
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    timeWhenViewDidDisappear = Date()
    print(
      "\(className) viewWillDisappear: \(timeWhenViewDidDisappear.timeIntervalSince(timeWhenViewWillDisappear))"
    )
  }
}
