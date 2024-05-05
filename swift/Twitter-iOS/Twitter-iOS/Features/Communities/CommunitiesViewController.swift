import UIKit

class CommunitiesViewController: UIViewController {
  private enum LayoutConstant {
    static let leadingPadding = 16.0
    static let headlineLabelTopPadding = 160.0
  }

  private enum LocalizedString {
    static let title = String(localized: "Communities")
    static let headlineLabelText = String(localized: "Discover new Communities")
    static let showMoreText = String(localized: "Show more")
  }

  private lazy var profileIconButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(slideInSideMenu))
    button.tintColor = .black
    button.image = UIImage(systemName: "person.circle.fill")
    return button
  }()

  private lazy var searchButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(pushCommunitiesSearchViewController)
    )
    button.image = UIImage(systemName: "magnifyingglass")
    return button
  }()

  private lazy var newCommunityCreationEntryPointButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(showNewCommunityCreationSheet))
    button.image = UIImage(systemName: "person.2")
    return button
  }()

  private let headlineLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = LocalizedString.headlineLabelText
    label.tintColor = .black
    label.sizeToFit()
    return label
  }()

  private let showMoreButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(LocalizedString.showMoreText, for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.sizeToFit()
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    view.addSubview(headlineLabel)
    view.addSubview(showMoreButton)

    NSLayoutConstraint.activate([
      headlineLabel.leadingAnchor.constraint(
        equalTo: view.leadingAnchor, constant: LayoutConstant.leadingPadding),
      headlineLabel.topAnchor.constraint(
        equalTo: view.topAnchor, constant: LayoutConstant.headlineLabelTopPadding),

      showMoreButton.leadingAnchor.constraint(equalTo: headlineLabel.leadingAnchor),
      showMoreButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])

    // set up the navigation header
    navigationController?.navigationBar.tintColor = .black
    title = LocalizedString.title
    navigationItem.leftBarButtonItems = [profileIconButton]
    navigationItem.rightBarButtonItems = [newCommunityCreationEntryPointButton, searchButton]

    showMoreButton.addAction(
      .init { _ in
        self.pushCommunitiesSearchViewController()
      }, for: .touchUpInside)
  }

  @objc
  private func slideInSideMenu() {}

  @objc
  private func showNewCommunityCreationSheet() {
    // We only show the sheet for non premium users.
    let blockedNewCommunityCreationBottomSheetViewController =
      BlockedNewCommunityCreationBottomSheetViewController()

    if let sheet = blockedNewCommunityCreationBottomSheetViewController.sheetPresentationController
    {
      sheet.detents = [.medium()]
      sheet.prefersGrabberVisible = true
    }
    present(blockedNewCommunityCreationBottomSheetViewController, animated: true, completion: nil)
  }

  @objc
  private func pushCommunitiesSearchViewController() {
    navigationController?.pushViewController(CommunitiesSearchViewController(), animated: true)
  }
}
