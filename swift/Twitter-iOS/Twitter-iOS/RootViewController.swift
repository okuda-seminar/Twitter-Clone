import UIKit

class RootViewController: UITabBarController {
  private enum TabBarItemTag: Int {
    case home
    case search
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
    homeViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: TabBarItemTag.home.rawValue)

    let searchViewController = SearchViewController()
    searchViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "magnifyingglass"), tag: TabBarItemTag.search.rawValue)

    viewControllers = [homeViewController, searchViewController]
  }
}
