import UIKit

class ExploreSettingsViewController: UIViewController {

  private enum LayoutConstant {
    static let edgeHorizontalPadding = 16.0
    static let headerViewHeight = 48.0
  }

  private let headerView: ExploreSettingsHeaderView = {
    let view = ExploreSettingsHeaderView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let bodyView: ExploreSettingsBodyView = {
    let view = ExploreSettingsBodyView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.addSubview(headerView)
    view.addSubview(bodyView)

    view.backgroundColor = .systemBackground

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      headerView.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.edgeHorizontalPadding),
      headerView.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgeHorizontalPadding),
      headerView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      headerView.heightAnchor.constraint(equalToConstant: LayoutConstant.headerViewHeight),

      bodyView.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.edgeHorizontalPadding),
      bodyView.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgeHorizontalPadding),
      bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
      bodyView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
    ])

    headerView.dismissButton.addAction(
      .init { _ in
        self.dismiss(animated: true)
      }, for: .touchUpInside)
  }
}
