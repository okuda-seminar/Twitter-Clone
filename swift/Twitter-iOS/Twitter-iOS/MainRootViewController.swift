import UIKit

class MainRootViewController: UITabBarController {

  public static var sharedInstance = MainRootViewController()

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

    let homeViewController = HomeViewController()
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
      rootViewController: SearchHomeViewController())
    searchViewController.tabBarItem = UITabBarItem(
      title: "", image: UIImage(systemName: "magnifyingglass"), tag: TabBarItemTag.search.rawValue)

    let communitiesViewController = UINavigationController(
      rootViewController: CommunitiesHomeViewController())
    communitiesViewController.tabBarItem = UITabBarItem(
      title: "", image: UIImage(systemName: "person.2"), tag: TabBarItemTag.communities.rawValue)

    let notificationsViewController = UINavigationController(
      rootViewController: NotificationsViewController())
    notificationsViewController.tabBarItem = UITabBarItem(
      title: "", image: UIImage(systemName: "bell"), tag: TabBarItemTag.notifications.rawValue)

    let messagesViewController = UINavigationController(
      rootViewController: MessagesViewController())
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
