import UIKit

class UserProfileViewController: UIViewController {

  public var userName: String = ""

  private enum LayoutConstant {
    static let backButtonTopPadding = 24.0
    static let backButtonSize = 28.0
    static let edgeHorizontalPadding = 16.0
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

    backButton.addAction(
      .init { _ in
        self.navigationController?.popViewController(animated: true)
      }, for: .touchUpInside)

    userNameLabel.text = userName
    userNameLabel.sizeToFit()

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      backButton.topAnchor.constraint(
        equalTo: layoutGuide.topAnchor, constant: LayoutConstant.backButtonTopPadding),
      backButton.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.edgeHorizontalPadding),
      backButton.widthAnchor.constraint(equalToConstant: LayoutConstant.backButtonSize),
      backButton.heightAnchor.constraint(equalToConstant: LayoutConstant.backButtonSize),

      userNameLabel.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor),
      userNameLabel.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
    ])
  }
}
