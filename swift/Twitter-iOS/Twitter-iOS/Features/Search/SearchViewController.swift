import UIKit

class SearchViewController: UIViewController {
  private enum LayoutConstant {
    static let headerHeight = 64.0
  }

  private let headerView: SearchHeaderView = {
    let view = SearchHeaderView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.addSubview(headerView)
    
    let layoutGuide = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      headerView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      headerView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      headerView.heightAnchor.constraint(equalToConstant: LayoutConstant.headerHeight),
    ])
  }
}
