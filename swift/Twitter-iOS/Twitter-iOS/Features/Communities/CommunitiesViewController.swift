import UIKit

class CommunitiesViewController: UIViewController {
  private enum LayoutConstant {
    static let headerViewHeight = 64.0
    static let leadingPadding = 16.0
  }

  private let headerView: CommunitiesHeaderView = {
    let view = CommunitiesHeaderView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let homeView: CommunitiesHomeView = {
    let view = CommunitiesHomeView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(headerView)
    view.addSubview(homeView)
    view.backgroundColor = .systemBackground

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      headerView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.leadingPadding),
      headerView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      headerView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      headerView.heightAnchor.constraint(equalToConstant: LayoutConstant.headerViewHeight),

      homeView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.leadingPadding),
      homeView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      homeView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
      homeView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
    ])
  }
}
