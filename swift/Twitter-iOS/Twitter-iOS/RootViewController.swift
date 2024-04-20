import UIKit

class RootViewController: UITabBarController {
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
    let homeViewController = HomeViewController()
    homeViewController.tabBarItem = UITabBarItem(
      title: "", image: UIImage(systemName: "house"), tag: TabBarItemTag.home.rawValue)

    let searchViewController = SearchViewController()
    searchViewController.tabBarItem = UITabBarItem(
      title: "", image: UIImage(systemName: "magnifyingglass"), tag: TabBarItemTag.search.rawValue)

    let communitiesViewController = CommunitiesViewController()
    communitiesViewController.tabBarItem = UITabBarItem(
      title: "", image: UIImage(systemName: "person"), tag: TabBarItemTag.communities.rawValue)

    let notificationsViewController = NotificationsViewController()
    notificationsViewController.tabBarItem = UITabBarItem(
      title: "", image: UIImage(systemName: "bell"), tag: TabBarItemTag.notifications.rawValue)

    let messagesViewController = MessagesViewController()
    messagesViewController.tabBarItem = UITabBarItem(
      title: "", image: UIImage(systemName: "envelope"), tag: TabBarItemTag.messages.rawValue)

    viewControllers = [
      homeViewController, searchViewController, communitiesViewController,
      notificationsViewController, messagesViewController,
    ]
  }
}
