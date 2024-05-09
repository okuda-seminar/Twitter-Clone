import UIKit

class MessagesViewController: UIViewController {

  private enum LayoutConstant {
    static let profileIconButtonSize = 28.0
    static let edgePadding = 16.0
  }

  private enum LocalizedString {
    static let title = String(localized: "Communities")
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
    view.addSubview(newMessageEntryPointButtonController.view)

    view.backgroundColor = .systemBackground

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      newMessageEntryPointButtonController.view.bottomAnchor.constraint(
        equalTo: layoutGuide.bottomAnchor, constant: -LayoutConstant.edgePadding),
      newMessageEntryPointButtonController.view.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),
    ])

    // set up navigation
    navigationItem.title = LocalizedString.title
  }
}
