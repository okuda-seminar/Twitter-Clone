import UIKit

class UserProfileViewController: UIViewController {

  public var userName: String = ""
  public var profileIcon: UIImage? {
    didSet {
      profileIconView.image = profileIcon
    }
  }

  public let profileIconView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.isUserInteractionEnabled = true
    return imageView
  }()

  private enum LayoutConstant {
    static let edgeHorizontalPadding = 16.0

    static let backButtonTopPadding = 24.0
    static let backButtonSize = 28.0

    static let profileIconViewTopPadding = 8.0
    static let profileIconViewSize = 48.0
  }

  private let userNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.tintColor = .black
    return label
  }()

  private let backButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
    button.contentMode = .scaleAspectFit
    button.tintColor = .white
    button.backgroundColor = .gray
    button.layer.cornerRadius = LayoutConstant.backButtonSize / 2
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground
    view.addSubview(backButton)
    view.addSubview(userNameLabel)
    view.addSubview(profileIconView)

    backButton.addAction(
      .init { _ in
        self.navigationController?.delegate = nil
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
      }, for: .touchUpInside)

    userNameLabel.text = userName
    userNameLabel.sizeToFit()

    let tapGestureRecognizer = UITapGestureRecognizer(
      target: self, action: #selector(presentUserProfileIconDetailViewController))
    profileIconView.addGestureRecognizer(tapGestureRecognizer)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      backButton.topAnchor.constraint(
        equalTo: layoutGuide.topAnchor, constant: LayoutConstant.backButtonTopPadding),
      backButton.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.edgeHorizontalPadding),
      backButton.widthAnchor.constraint(equalToConstant: LayoutConstant.backButtonSize),
      backButton.heightAnchor.constraint(equalToConstant: LayoutConstant.backButtonSize),

      profileIconView.leadingAnchor.constraint(equalTo: backButton.leadingAnchor),
      profileIconView.topAnchor.constraint(
        equalTo: backButton.bottomAnchor, constant: LayoutConstant.profileIconViewTopPadding),
      profileIconView.widthAnchor.constraint(equalToConstant: LayoutConstant.profileIconViewSize),
      profileIconView.heightAnchor.constraint(equalToConstant: LayoutConstant.profileIconViewSize),

      userNameLabel.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor),
      userNameLabel.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
    ])

    // Hide navigation bar
    navigationController?.setNavigationBarHidden(true, animated: false)
  }

  @objc
  private func presentUserProfileIconDetailViewController() {
    let userProfileIconDetailViewController = UserProfileIconDetailViewController()
    userProfileIconDetailViewController.modalPresentationStyle = .fullScreen
    userProfileIconDetailViewController.profileIcon = profileIcon
    navigationController?.delegate = self
    navigationController?.pushViewController(
      userProfileIconDetailViewController, animated: true)
  }
}

extension UserProfileViewController: UINavigationControllerDelegate {
  func navigationController(
    _ navigationController: UINavigationController,
    animationControllerFor operation: UINavigationController.Operation,
    from fromVC: UIViewController, to toVC: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    switch operation {
    case .push:
      let animator = UserProfileIconTransition()
      animator.presenting = true
      return animator
    case .pop:
      return nil
    default:
      return nil
    }
  }
}
