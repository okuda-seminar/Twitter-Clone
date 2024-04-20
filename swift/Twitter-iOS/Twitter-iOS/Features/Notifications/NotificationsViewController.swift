import UIKit

class NotificationsViewController: UIViewController {

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

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    view.addSubview(headerView)
    
    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      headerView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      headerView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
    ])

    headerView.delegate = self
  }
}

extension NotificationsViewController: NotificationsHeaderViewDelegate {
  func didTapTabButton(_ button: UIButton) {
    selectedButton = button
  }
}
