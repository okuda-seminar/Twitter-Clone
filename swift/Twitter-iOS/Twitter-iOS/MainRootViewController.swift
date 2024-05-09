import UIKit

class MainRootViewController: UITabBarController {
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
    let homeNavigationController = UINavigationController(rootViewController: HomeViewController())
    homeNavigationController.setNavigationBarHidden(true, animated: false)
    homeNavigationController.tabBarItem = UITabBarItem(
      title: "", image: UIImage(systemName: "house"), tag: TabBarItemTag.home.rawValue)

    let searchViewController = UINavigationController(
      rootViewController: SearchHomeViewController())
    searchViewController.tabBarItem = UITabBarItem(
      title: "", image: UIImage(systemName: "magnifyingglass"), tag: TabBarItemTag.search.rawValue)

    let communitiesViewController = UINavigationController(
      rootViewController: CommunitiesViewController())
    communitiesViewController.tabBarItem = UITabBarItem(
      title: "", image: UIImage(systemName: "person.2"), tag: TabBarItemTag.communities.rawValue)

    let notificationsViewController = NotificationsViewController()
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
  }
}
