import UIKit

class RootViewController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()

    setUpTabBar()
    setUpSubviews()
  }

  private func setUpTabBar() {
    tabBar.backgroundColor = .systemBackground
  }

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground

    let homeViewController = HomeViewController()
    homeViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: 0)

    let searchViewController = SearchViewController()
    searchViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "magnifyingglass"), tag: 1)

    viewControllers = [homeViewController, searchViewController]
  }
}
