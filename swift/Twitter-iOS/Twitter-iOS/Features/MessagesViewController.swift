import UIKit

class MessagesViewController: UIViewController {

  private enum LayoutConstant {
    static let headerHeight = 44.0
    static let horizontalPadding = 16.0
  }

  private let headerView: MessagesHeaderView = {
    let view = MessagesHeaderView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.addSubview(headerView)

    view.backgroundColor = .systemBackground

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      headerView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.horizontalPadding),
      headerView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.horizontalPadding),
      headerView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      headerView.heightAnchor.constraint(equalToConstant: LayoutConstant.headerHeight),
    ])
  }
}
