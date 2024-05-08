import UIKit

class MessagesViewController: UIViewController, MainViewControllerWithSideMenu {

  public let profileIconButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "person.circle.fill"), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .black
    button.imageView?.contentMode = .scaleAspectFit
    button.contentHorizontalAlignment = .fill
    button.contentVerticalAlignment = .fill
    return button
  }()

  private enum LayoutConstant {
    static let profileIconButtonSize = 28.0
    static let edgePadding = 16.0
  }

  private lazy var newMessageEntryPointButtonController: NewMessageEntrypointButtonController = {
    let viewController = NewMessageEntrypointButtonController()
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(viewController)
    viewController.didMove(toParent: self)
    return viewController
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.addSubview(profileIconButton)
    view.addSubview(newMessageEntryPointButtonController.view)

    view.backgroundColor = .systemBackground

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      profileIconButton.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      profileIconButton.topAnchor.constraint(
        equalTo: layoutGuide.topAnchor, constant: LayoutConstant.edgePadding),
      profileIconButton.widthAnchor.constraint(
        equalToConstant: LayoutConstant.profileIconButtonSize),
      profileIconButton.heightAnchor.constraint(
        equalToConstant: LayoutConstant.profileIconButtonSize),

      newMessageEntryPointButtonController.view.bottomAnchor.constraint(
        equalTo: layoutGuide.bottomAnchor, constant: -LayoutConstant.edgePadding),
      newMessageEntryPointButtonController.view.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),
    ])
  }
}
