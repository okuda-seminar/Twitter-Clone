import UIKit

class SearchInputViewController: UIViewController {
  private enum LayoutConstant {
    static let headlineLabelTopPadding = 8.0
    static let edgeHorizontalPadding = 16.0
  }

  private enum LocalizedString {
    static let cancelButtonTitle = String(localized: "Cancel")
    static let title = String(localized: "Search")
    static let headlineText = String(localized: "Recent searches")
  }

  private lazy var cancelButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: LocalizedString.cancelButtonTitle, style: .plain, target: self,
      action: #selector(dismissByTappingCancelButton))
    let attributes: [NSAttributedString.Key: Any] = [
      .underlineStyle: NSUnderlineStyle.single.rawValue, .underlineColor: UIColor.black,
    ]
    button.setTitleTextAttributes(attributes, for: .normal)
    button.tintColor = .black
    return button
  }()

  private let headelineLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = LocalizedString.headlineText
    label.textColor = .black
    label.sizeToFit()
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground
    view.addSubview(headelineLabel)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      headelineLabel.topAnchor.constraint(
        equalTo: layoutGuide.topAnchor, constant: LayoutConstant.headlineLabelTopPadding),
      headelineLabel.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.edgeHorizontalPadding),
    ])

    // set up navigation bar
    navigationItem.backButtonDisplayMode = .minimal
    navigationItem.rightBarButtonItems = []
    let searchBar = UISearchBar()
    searchBar.placeholder = LocalizedString.title
    searchBar.barTintColor = .blue
    searchBar.showsCancelButton = true
    navigationItem.titleView = searchBar
  }

  @objc
  private func dismissByTappingCancelButton() {
    navigationController?.popViewController(animated: true)
  }
}
