import UIKit

class RootViewController: UIViewController {
  private lazy var mainViewController: MainRootViewController = {
    let viewController = MainRootViewController()
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(viewController)
    viewController.didMove(toParent: self)
    return viewController
  }()

  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()

  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    return stackView
  }()

  private let overlayView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .brandedLightGrayBackground
    view.alpha = 0.0
    return view
  }()

  private lazy var sideMenuViewController: SideMenuViewController = {
    var viewController = SideMenuViewController()
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(viewController)
    viewController.didMove(toParent: self)
    return viewController
  }()

  private lazy var backGroundTapGestureRecognizer: UITapGestureRecognizer = {
    var gestureRecognizer = UITapGestureRecognizer()
    gestureRecognizer.addTarget(self, action: #selector(hideSideMenu))
    return gestureRecognizer
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpSubviews()
  }

  private func setUpSubviews() {
    stackView.addArrangedSubview(sideMenuViewController.view)
    stackView.addArrangedSubview(mainViewController.view)
    scrollView.addSubview(stackView)
    view.addSubview(scrollView)
    view.addSubview(overlayView)
    view.backgroundColor = .systemBackground

    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

      stackView.topAnchor.constraint(equalTo: view.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
      sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      mainViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
      mainViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      mainViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor),

      overlayView.topAnchor.constraint(equalTo: mainViewController.view.topAnchor),
      overlayView.leadingAnchor.constraint(equalTo: mainViewController.view.leadingAnchor),
      overlayView.bottomAnchor.constraint(equalTo: mainViewController.view.bottomAnchor),
      overlayView.trailingAnchor.constraint(equalTo: mainViewController.view.trailingAnchor),
    ])

    //    mainViewController.profileIconButton.addAction(
    //      .init { _ in
    //        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    //        self.overlayView.alpha = 1.0
    //        self.overlayView.layer.opacity = 0.5
    //      }, for: .touchUpInside)
    overlayView.addGestureRecognizer(backGroundTapGestureRecognizer)

    Task {
      resetToDefault()
    }
  }

  @objc
  private func hideSideMenu() {
    scrollView.setContentOffset(
      CGPoint(x: sideMenuViewController.view.frame.width, y: 0), animated: true)
    mainViewController.view.backgroundColor = .systemBackground
    overlayView.alpha = 0.0
  }

  private func resetToDefault() {
    overlayView.alpha = 0.0
    scrollView.setContentOffset(
      CGPoint(x: sideMenuViewController.view.frame.width, y: 0), animated: false)
  }
}

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
