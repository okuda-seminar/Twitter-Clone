import UIKit

class NotificationsViewController: UIViewController {

  private enum LayoutConstant {
    static let edgePadding = 16.0
  }

  private let headerView: NotificationsHeaderView = {
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

  private let newTweetEntryPointButton: NewTweetEntrypointButton = {
    let button = NewTweetEntrypointButton()
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    view.addSubview(headerView)
    view.addSubview(newTweetEntryPointButton)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      headerView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      headerView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),

      newTweetEntryPointButton.bottomAnchor.constraint(
        equalTo: layoutGuide.bottomAnchor, constant: -LayoutConstant.edgePadding),
      newTweetEntryPointButton.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),
    ])

    headerView.delegate = self
  }
}

extension NotificationsViewController: NotificationsHeaderViewDelegate {
  func didTapTabButton(_ button: UIButton) {
    selectedButton = button
  }
}
