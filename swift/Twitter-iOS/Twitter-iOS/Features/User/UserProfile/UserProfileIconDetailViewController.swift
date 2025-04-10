import UIKit

class UserProfileIconDetailViewController: UIViewController {

  public var currentUser: CurrentUser

  public lazy var profileIconView: UIImageView = {
    let imageView = UIImageView(image: currentUser.icon)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private enum LayoutConstant {
    static let edgePadding = 16.0
    static let closeButtonSize = 28.0
    static let profileIconViewSize = 256.0
  }

  private let closeButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "multiply"), for: .normal)
    button.contentMode = .scaleAspectFit
    button.tintColor = .white
    button.backgroundColor = .gray
    button.layer.cornerRadius = LayoutConstant.closeButtonSize / 2
    return button
  }()

  public init(currentUser: CurrentUser) {
    self.currentUser = currentUser
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = .black
    view.addSubview(closeButton)
    view.addSubview(profileIconView)

    closeButton.addAction(
      .init { [weak self] _ in
        self?.navigationController?.popViewController(animated: true)
      }, for: .touchUpInside)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      closeButton.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.edgePadding),
      closeButton.topAnchor.constraint(
        equalTo: layoutGuide.topAnchor, constant: LayoutConstant.edgePadding),
      closeButton.widthAnchor.constraint(equalToConstant: LayoutConstant.closeButtonSize),
      closeButton.heightAnchor.constraint(equalToConstant: LayoutConstant.closeButtonSize),

      profileIconView.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
      profileIconView.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor),
      profileIconView.widthAnchor.constraint(equalToConstant: LayoutConstant.profileIconViewSize),
      profileIconView.heightAnchor.constraint(equalToConstant: LayoutConstant.profileIconViewSize),
    ])
  }
}
