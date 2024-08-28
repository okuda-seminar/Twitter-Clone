import DrawerPresentation
import SwiftUI
import UIKit

class AppRootViewController: UITabBarController {

  public static var sharedInstance = AppRootViewController()

  private enum TabBarItemTag: Int {
    case home
    case search
    case communities
    case notifications
    case messages
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpTabBar()
    setUpSubviews()
  }

  private func setUpTabBar() {
    tabBar.backgroundColor = .systemBackground
  }

  private func setUpSubviews() {
    let notificationCenter = NotificationCenter.default

    let homeViewController = HomeViewController(delegate: self)
    let homeNavigationController = UINavigationController(
      rootViewController: homeViewController)
    homeNavigationController.tabBarItem = UITabBarItem(
      title: "", image: UIImage(systemName: "house"), tag: TabBarItemTag.home.rawValue)
    notificationCenter.addObserver(
      self, selector: #selector(didTapHomeTabBarItem), name: .didTapHomeTabBarItem, object: nil)
    notificationCenter.addObserver(
      self, selector: #selector(didLongPressHomeTabBarItem), name: .didLongPressHomeTabBarItem,
      object: nil)

    let searchViewController = UINavigationController(
      rootViewController: SearchHomeViewController(delegate: self))
    searchViewController.tabBarItem = UITabBarItem(
      title: "", image: UIImage(systemName: "magnifyingglass"), tag: TabBarItemTag.search.rawValue)

    let communitiesViewController = UINavigationController(
      rootViewController: CommunitiesHomeViewController(delegate: self))
    communitiesViewController.tabBarItem = UITabBarItem(
      title: "", image: UIImage(systemName: "person.2"), tag: TabBarItemTag.communities.rawValue)

    let notificationsViewController = UINavigationController(
      rootViewController: NotificationsViewController(delegate: self))
    notificationsViewController.tabBarItem = UITabBarItem(
      title: "", image: UIImage(systemName: "bell"), tag: TabBarItemTag.notifications.rawValue)

    let messagesViewController = UINavigationController(
      rootViewController: MessagesViewController(delegate: self))
    messagesViewController.tabBarItem = UITabBarItem(
      title: "", image: UIImage(systemName: "envelope"), tag: TabBarItemTag.messages.rawValue)

    viewControllers = [
      homeNavigationController, searchViewController, communitiesViewController,
      notificationsViewController, messagesViewController,
    ]

    tabBar.addSubview(homeViewController.tabBarItemOverlayView)
    let tabBarButton = tabBar.subviews[TabBarItemTag.home.rawValue]
    let overlayView = homeViewController.tabBarItemOverlayView
    NSLayoutConstraint.activate([
      overlayView.topAnchor.constraint(equalTo: tabBarButton.topAnchor),
      overlayView.leadingAnchor.constraint(equalTo: tabBarButton.leadingAnchor),
      overlayView.bottomAnchor.constraint(equalTo: tabBarButton.bottomAnchor),
      overlayView.trailingAnchor.constraint(equalTo: tabBarButton.trailingAnchor),
    ])
  }

  private func hideSideMenu() {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/409
    // - Enable Smoother Transitions from SideMenu to Other Views.
    self.dismiss(animated: true)
  }

  // MARK: - NSNotification

  @objc
  private func didTapHomeTabBarItem() {
    selectedIndex = TabBarItemTag.home.rawValue
  }

  @objc
  private func didLongPressHomeTabBarItem() {
    selectedIndex = TabBarItemTag.home.rawValue
  }
}

extension AppRootViewController: SideMenuViewDelegate {

  func didTapUserProfile() {
    hideSideMenu()
    guard
      let selectedViewController = self.selectedViewController
        as? UINavigationController
    else { return }
    let userProfileViewController = UserProfileViewController(userModel: InjectCurrentUser())
    selectedViewController.pushViewController(userProfileViewController, animated: true)
  }

  func didTapBookmarks() {
    hideSideMenu()
    guard
      let selectedViewController = self.selectedViewController
        as? UINavigationController
    else { return }
    let userBookmarksPageViewController = UserBookmarksPageViewController()
    selectedViewController.pushViewController(userBookmarksPageViewController, animated: true)
  }

  func didTapJobs() {
    hideSideMenu()
    guard
      let selectedViewController = self.selectedViewController
        as? UINavigationController
    else { return }
    selectedViewController.pushViewController(JobsViewController(), animated: true)
  }

  func didTapFollowerRequests() {
    hideSideMenu()
    guard
      let selectedViewController = self.selectedViewController
        as? UINavigationController
    else { return }
    let userFollowerRequestsPageViewController = UserFollowerRequestsPageViewController()
    selectedViewController.pushViewController(
      userFollowerRequestsPageViewController, animated: true)
  }

  func didTapSettingsAndPrivacy() {
    hideSideMenu()
    guard
      let selectedViewController = self.selectedViewController
        as? UINavigationController
    else { return }
    let settingsViewController = SettingsHomeViewController()
    selectedViewController.pushViewController(settingsViewController, animated: true)
  }

  func didTapUserFollowRelationsButton(userName: String) {
    hideSideMenu()
    guard
      let selectedViewController = self.selectedViewController
        as? UINavigationController
    else { return }
    let userFollowRelationsViewController = UserFollowRelationsViewController(userName: userName)
    selectedViewController.pushViewController(userFollowRelationsViewController, animated: true)
  }
}

class ViewControllerWithUserIconButton: UIViewController {

  private let drawerController = DrawerTransitionController()
  public weak var delegate: SideMenuViewDelegate?

  init(delegate: SideMenuViewDelegate) {
    self.delegate = delegate
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private lazy var sideMenuHostingController: UIHostingController = {
    let fakeUser = createFakeUser()
    let controller = UIHostingController(
      rootView: SideMenuView(
        userName: fakeUser.userName, numOfFollowing: fakeUser.numOfFollowing,
        numOfFollowers: fakeUser.numOfFollowers, delegate: delegate))
    return controller
  }()

  // MARK: View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpDrawerController()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setUpNavigation()
  }

  private func setUpDrawerController() {
    drawerController.addDrawerGesture(
      to: self,
      drawerViewController: {
        self.sideMenuHostingController
      })
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
    drawerController.presentRegisteredDrawer()
  }
}
