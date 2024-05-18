import SwiftUI
import UIKit

class AppRootViewController: UIViewController {

  private lazy var mainRootViewController: MainRootViewController = {
    let viewController = MainRootViewController()
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(viewController)
    viewController.didMove(toParent: self)
    return viewController
  }()

  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.showsVerticalScrollIndicator = false
    scrollView.bounces = false
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
    stackView.addArrangedSubview(mainRootViewController.view)
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
      stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),

      sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
      sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      mainRootViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
      mainRootViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      mainRootViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor),

      overlayView.topAnchor.constraint(equalTo: mainRootViewController.view.topAnchor),
      overlayView.leadingAnchor.constraint(equalTo: mainRootViewController.view.leadingAnchor),
      overlayView.bottomAnchor.constraint(equalTo: mainRootViewController.view.bottomAnchor),
      overlayView.trailingAnchor.constraint(equalTo: mainRootViewController.view.trailingAnchor),
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

  func didTapUserProfile() {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    let userProfileViewController = UserProfileViewController()
    userProfileViewController.userName = "Default user name"
    selectedViewController.pushViewController(userProfileViewController, animated: true)
  }

  func didTapSettingsAndPrivacy() {
    hideSideMenu()
    guard
      let selectedViewController = mainRootViewController.selectedViewController
        as? UINavigationController
    else { return }
    let settingsViewController = SettingsHomeViewController()
    selectedViewController.pushViewController(settingsViewController, animated: true)
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