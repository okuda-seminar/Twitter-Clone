import UIKit

class CommunitiesViewController: UIViewController {
  private enum LayoutConstant {
    static let edgePadding = 16.0
    static let collectionViewVerticalPadding = 16.0
    static let collectionViewCellHeight = 44.0
  }

  private enum LocalizedString {
    static let title = String(localized: "Communities")
    static let headlineLabelText = String(localized: "Discover new Communities")
    static let showMoreText = String(localized: "Show more")
  }

  private var communities = ["sample", "community", "with", "collection view"]

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
    button.tintColor = .black
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
    button.setTitleColor(.branededLightBlue, for: .normal)
    button.sizeToFit()
    return button
  }()

  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(
      CommunitiesCollectionViewCell.self,
      forCellWithReuseIdentifier: "CommunitiesCollectionViewCell")
    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    view.addSubview(headlineLabel)
    view.addSubview(showMoreButton)
    view.addSubview(collectionView)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      headlineLabel.leadingAnchor.constraint(
        equalTo: view.leadingAnchor, constant: LayoutConstant.edgePadding),
      headlineLabel.topAnchor.constraint(
        equalTo: layoutGuide.topAnchor, constant: LayoutConstant.edgePadding),

      collectionView.topAnchor.constraint(
        equalTo: headlineLabel.bottomAnchor, constant: LayoutConstant.collectionViewVerticalPadding),
      collectionView.leadingAnchor.constraint(equalTo: headlineLabel.leadingAnchor),
      collectionView.bottomAnchor.constraint(
        equalTo: showMoreButton.topAnchor, constant: -LayoutConstant.collectionViewVerticalPadding),
      collectionView.trailingAnchor.constraint(
        equalTo: view.trailingAnchor, constant: -LayoutConstant.edgePadding),

      showMoreButton.leadingAnchor.constraint(equalTo: headlineLabel.leadingAnchor),
      showMoreButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])

    // set up the navigation header
    navigationController?.navigationBar.tintColor = .black
    navigationItem.title = LocalizedString.title
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
    navigationItem.backButtonDisplayMode = .minimal
    navigationController?.pushViewController(CommunitiesSearchViewController(), animated: true)
  }
}

extension CommunitiesViewController: UICollectionViewDelegate {}

extension CommunitiesViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
    -> Int
  {
    return communities.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell
  {
    let cell =
      collectionView.dequeueReusableCell(
        withReuseIdentifier: "CommunitiesCollectionViewCell", for: indexPath)
      as! CommunitiesCollectionViewCell
    cell.titleLabel.text = communities[indexPath.row]
    cell.titleLabel.sizeToFit()
    cell.backgroundColor = .branededLightBlue
    return cell
  }
}

extension CommunitiesViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(
      width: collectionView.frame.width, height: LayoutConstant.collectionViewCellHeight)
  }
}
