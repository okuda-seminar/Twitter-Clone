import SwiftUI
import UIKit
import XLPagerTabStrip

/// The view controller that manages a tab view displaying a collection of posts.
class UserProfileTabViewController: UIViewController {

  // MARK: - Private Props

  /// The set of constant values used for layout configurations.
  private enum LayoutConstant {
    static let cellCount: Int = 30
    static let cellHeight: CGFloat = 238.17
    static let minimumLineSpacing: CGFloat = 0.0
  }

  /// The collection view displaying a collection of posts.
  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()

  // MARK: - Public Props

  /// The index of the tab used for paging in the container view.
  public var pageIndex: Int = 0

  /// The title of the tab displayed in the tab bar.
  public var pageTitle: String?

  // MARK: - Private API

  /// Sets up the collection view by configuring its delegate, data source, and registering the cell type.
  private func setUpCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(
      UserPostsCollectionViewCell.self,
      forCellWithReuseIdentifier: UserPostsCollectionViewCell.identifier)
  }

  /// Adds the collection view to the view hierarchy and configures layout constraints.
  private func setUpSubviews() {
    view.backgroundColor = .systemBackground
    view.addSubview(collectionView)
    let layoutGuide = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      collectionView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
    ])
  }

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpCollectionView()
    setUpSubviews()
  }
}

extension UserProfileTabViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
    -> Int
  {
    return LayoutConstant.cellCount
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell
  {
    guard
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: UserPostsCollectionViewCell.identifier, for: indexPath)
        as? UserPostsCollectionViewCell
    else {
      fatalError("Failed to dequeue cell")
    }
    return cell
  }
}

extension UserProfileTabViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(
    _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: LayoutConstant.cellHeight)
  }

  func collectionView(
    _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return LayoutConstant.minimumLineSpacing
  }
}

extension UserProfileTabViewController: IndicatorInfoProvider {
  /// Provides the tab title required for the tab bar.
  ///
  /// - Parameter pagerTabStripController: The view controller that manages tab view controllers and paging functionality.
  /// - Returns: The tab title information.
  func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController)
    -> XLPagerTabStrip.IndicatorInfo
  {
    return IndicatorInfo.init(title: pageTitle ?? "\(pageIndex)")
  }
}

#Preview {
  UserProfileTabViewController()
}
