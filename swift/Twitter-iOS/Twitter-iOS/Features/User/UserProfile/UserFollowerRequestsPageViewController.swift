import UIKit

class UserFollowerRequestsPageViewController: UIViewController {

  private enum LayoutConstant {
    static let edgePadding: CGFloat = 16.0

    static let headlineFontSize: CGFloat = 29.0
    static let subHeadlineFontSize: CGFloat = 15.0
    static let headlineViewSpacing: CGFloat = 10.0
    static let headlineViewVerticalPadding: CGFloat = 50.0

    static let headerTitleFontSize: CGFloat = 18.0

    static let backButtonSize: CGFloat = 20.0
  }

  private enum LocalizedString {
    static let headlineText = String(localized: "You're up to date")
    static let subHeadlineText = String(
      localized:
        "When someone requests to follow you, it'll show up here for you to accept or decline."
    )
    static let title = String(localized: "Follower requests")
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

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
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
    navigationController?.navigationBar.backgroundColor = .systemBackground
  }
}
