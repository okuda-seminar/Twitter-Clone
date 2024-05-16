import SwiftUI
import UIKit

class MessagesViewController: ViewControllerWithUserIconButton {

  private enum LayoutConstant {
    static let profileIconButtonSize = 28.0
    static let edgePadding = 16.0
  }

  private enum LocalizedString {
    static let title = String(localized: "Messages")
  }

  private lazy var profileIconButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(showSideMenu))
    button.tintColor = .black
    button.image = UIImage(systemName: "person.circle.fill")
    return button
  }()

  private lazy var exploreSettingsEntryPointButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(showMessagesSettings))
    button.tintColor = .black
    button.image = UIImage(systemName: "gear")
    return button
  }()

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
    navigationItem.leftBarButtonItems = [profileIconButton]
    navigationItem.rightBarButtonItems = [exploreSettingsEntryPointButton]
  }

  // MARK: - Settings

  @objc
  private func showMessagesSettings() {
    let messagesSettingsViewController = UIHostingController(rootView: MessagesSettingsView())
    messagesSettingsViewController.modalPresentationStyle = .fullScreen
    present(messagesSettingsViewController, animated: true)
  }
}
