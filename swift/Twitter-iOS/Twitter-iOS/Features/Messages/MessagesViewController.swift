import SwiftUI
import UIKit

class MessagesViewController: ViewControllerWithUserIconButton {

  private enum LayoutConstant {
    static let profileIconButtonSize: CGFloat = 28.0
    static let edgePadding: CGFloat = 16.0
    static let headlineViewVerticalEdgePadding: CGFloat = 34
    static let headlineViewSpacing: CGFloat = 10
    static let writeMessageButtonVerticalEdgePadding: CGFloat = 25
    static let headlineFontSize: CGFloat = 29
    static let subHeadlineFontSize: CGFloat = 15
  }

  private enum LocalizedString {
    static let title = String(localized: "Messages")
    static let headlineText = String(localized: "Welcome to your inbox!")
    static let subHeadlineText = String(
      localized:
        "Drop a line, share posts and more with private conversations between you and others on Twitter."
    )
  }

  private let headlineLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = LocalizedString.headlineText
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: LayoutConstant.headlineFontSize, weight: .heavy)
    return label
  }()

  private let subHeadlineLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = LocalizedString.subHeadlineText
    label.textColor = .gray
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: LayoutConstant.subHeadlineFontSize)
    return label
  }()

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

  private lazy var writeMessageButtonController: NewMessageEntrypointButtonController = {
    let viewController = NewMessageEntrypointButtonController(buttonType: .writeMessageButton)
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(viewController)
    viewController.didMove(toParent: self)
    return viewController
  }()

  private lazy var newMessageEntryPointButtonController: NewMessageEntrypointButtonController = {
    let viewController = NewMessageEntrypointButtonController(
      buttonType: .newMessageEntrypointButton)
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
    let headlineView = UIStackView(arrangedSubviews: [headlineLabel, subHeadlineLabel])
    headlineView.axis = .vertical
    headlineView.spacing = LayoutConstant.headlineViewSpacing
    headlineView.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(headlineView)
    view.addSubview(writeMessageButtonController.view)
    view.addSubview(newMessageEntryPointButtonController.view)

    view.backgroundColor = .systemBackground

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      headlineView.topAnchor.constraint(
        equalTo: layoutGuide.topAnchor, constant: LayoutConstant.headlineViewVerticalEdgePadding),
      headlineView.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.edgePadding),
      headlineView.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),

      writeMessageButtonController.view.topAnchor.constraint(
        equalTo: headlineView.bottomAnchor,
        constant: LayoutConstant.writeMessageButtonVerticalEdgePadding),
      writeMessageButtonController.view.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.edgePadding),

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
