import SwiftUI
import UIKit

class NotificationsViewController: UIViewController {

  private enum LayoutConstant {
    static let edgePadding = 16.0
  }

  private let headerView: NotificationsHeaderView = {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/138 - Replace custom home header view with Apple's navigation bar items.
    let view = NotificationsHeaderView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var selectedButton: UIButton = headerView.tabButtons[0] {
    didSet {
      guard selectedButton != oldValue else { return }
      oldValue.isSelected = false
      selectedButton.isSelected = true
    }
  }

  private let newTweetEntryPointButtonController = NewTweetEntrypointButtonController()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    view.addSubview(headerView)
    view.addSubview(newTweetEntryPointButtonController.view)

    addChild(newTweetEntryPointButtonController)
    newTweetEntryPointButtonController.didMove(toParent: self)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      headerView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      headerView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),

      newTweetEntryPointButtonController.view.bottomAnchor.constraint(
        equalTo: layoutGuide.bottomAnchor, constant: -LayoutConstant.edgePadding),
      newTweetEntryPointButtonController.view.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),
    ])

    headerView.delegate = self
    headerView.settingsEntryPointButton.addAction(
      .init { _ in
        let viewController = UIHostingController(
          rootView: SettingsHomeView())
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
      }, for: .touchUpInside)
  }

  @objc
  private func showNotificationsSettings() {
  }
}

extension NotificationsViewController: NotificationsHeaderViewDelegate {
  func didTapTabButton(_ button: UIButton) {
    selectedButton = button
  }
}
