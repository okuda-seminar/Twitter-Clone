import UIKit

class SearchInputViewController: UIViewController {
  private enum LocalizedString {
    static let cancelButtonTitle = String(localized: "Cancel")
    static let title = String(localized: "Search")
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
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    // set up navigation bar
    let backButtonImage = UIImage(systemName: "arrow.left")
    navigationController?.navigationBar.backIndicatorImage = backButtonImage
    navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    navigationItem.rightBarButtonItems = [cancelButton]
    let searchBar = UISearchBar()
    searchBar.placeholder = LocalizedString.title
    navigationItem.titleView = searchBar
  }

  @objc
  private func dismissByTappingCancelButton() {
    dismiss(animated: true)
  }
}
