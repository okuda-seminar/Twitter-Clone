import UIKit

class UserBookmarksPageViewController: UIViewController {

  private enum LayoutConstant {
    static let edgePadding: CGFloat = 16.0

    static let headlineFontSize: CGFloat = 29
    static let subHeadlineFontSize: CGFloat = 15
    static let headlineViewSpacing: CGFloat = 10
    static let headlineViewVerticalPadding: CGFloat = 50

    static let headerTitleFontSize: CGFloat = 18

    static let backButtonSize: CGFloat = 20.0
  }

  private enum LocalizedString {
    static let headlineText = String(localized: "Save Posts for later")
    static let subHeadlineText = String(
      localized:
        "Don't let the good ones fly away! Bookmarks posts to easily find them again in the future."
    )
    static let title = String(localized: "Bookmarks")
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

  private let menuButton: UIBarButtonItem = {
    let button = UIBarButtonItem()
    button.tintColor = .black
    button.image = UIImage(systemName: "ellipsis")
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setSubviews()
  }

  private func setSubviews() {
    let headlineView = UIStackView(arrangedSubviews: [headlineLabel, subHeadlineLabel])
    headlineView.axis = .vertical
    headlineView.spacing = LayoutConstant.headlineViewSpacing
    headlineView.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(headlineView)
    view.backgroundColor = .systemBackground

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      headlineView.topAnchor.constraint(
        equalTo: layoutGuide.topAnchor, constant: LayoutConstant.headlineViewVerticalPadding),
      headlineView.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.edgePadding),
      headlineView.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),
    ])

    // set up navigation
    navigationItem.backButtonDisplayMode = .minimal
    navigationItem.title = LocalizedString.title
    navigationItem.rightBarButtonItems = [menuButton]
    navigationController?.navigationBar.backgroundColor = .systemBackground
  }
}
