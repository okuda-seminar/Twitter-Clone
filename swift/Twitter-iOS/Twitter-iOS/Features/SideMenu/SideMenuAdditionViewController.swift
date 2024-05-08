import UIKit

class SideMenuAdditionViewController: UIViewController {
  public var mainViewController: MainViewControllerWithSideMenu? {
    didSet {
      guard let mainViewController else { return }
      addChild(mainViewController)
      mainViewController.didMove(toParent: self)
      mainViewController.view.translatesAutoresizingMaskIntoConstraints = false
    }
  }

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
    guard let mainViewController else { return }

    for subView in stackView.arrangedSubviews {
      stackView.removeArrangedSubview(subView)
    }

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

    mainViewController.profileIconButton.addAction(
      .init { _ in
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        self.overlayView.alpha = 1.0
      }, for: .touchUpInside)
    overlayView.addGestureRecognizer(backGroundTapGestureRecognizer)

    Task {
      scrollView.setContentOffset(
        CGPoint(x: sideMenuViewController.view.frame.width, y: 0), animated: false)
    }
  }

  @objc
  private func hideSideMenu() {
    scrollView.setContentOffset(
      CGPoint(x: sideMenuViewController.view.frame.width, y: 0), animated: true)
    mainViewController?.view.backgroundColor = .systemBackground
    overlayView.alpha = 0.0
  }
}

protocol MainViewControllerWithSideMenu: UIViewController {
  var profileIconButton: UIButton { get }
}
