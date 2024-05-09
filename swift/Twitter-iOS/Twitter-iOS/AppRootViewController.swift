import UIKit

class AppRootViewController: UIViewController {

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
    viewController.sideMenuViewDelegate = self
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(viewController)
    viewController.didMove(toParent: self)
    return viewController
  }()

  private lazy var backGroundTapGestureRecognizer: UITapGestureRecognizer = {
    var gestureRecognizer = UITapGestureRecognizer()
    gestureRecognizer.addTarget(self, action: #selector(didTapOverlayView))
    return gestureRecognizer
  }()

  // MARK: - Layout

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

    overlayView.addGestureRecognizer(backGroundTapGestureRecognizer)

    Task {
      hideSideMenu(animated: false)
    }
  }

  // MARK: - Public API

  public func showSideMenu() {
    scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    overlayView.alpha = 1.0
    overlayView.layer.opacity = 0.5
  }

  @objc
  public func hideSideMenu(animated: Bool = true) {
    scrollView.setContentOffset(
      CGPoint(x: sideMenuViewController.view.frame.width, y: 0), animated: animated)
    overlayView.alpha = 0.0
  }

  // Private API
  @objc
  private func didTapOverlayView() {
    // Without this wrap, animated becomes false when tapping overlay view.
    hideSideMenu()
  }
}

extension AppRootViewController: SideMenuViewDelegate {
  func didTapUserIconButton() {
    hideSideMenu()
  }
}

class ViewControllerWithUserIconButton: UIViewController {

  private var rootViewController: UIViewController {
    var viewController = self as UIViewController
    while let parent = viewController.parent {
      viewController = parent
    }
    return viewController
  }

  @objc
  public func showSideMenu() {
    guard let rootViewController = self.rootViewController as? AppRootViewController else { return }
    rootViewController.showSideMenu()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    guard let rootViewController = self.rootViewController as? AppRootViewController else { return }
    rootViewController.hideSideMenu(animated: false)
  }
}
