import SwiftUI
import UIKit

final class HomeTabViewController: UIViewController {

  // MARK: - Public variables

  public var tweets: [TweetModel]? {
    didSet {
      setUpSubviews()
    }
  }

  public weak var delegate: HomeTabViewControllerDelegate?

  // MARK: - Private variables

  private enum LayoutConstant {
    static let collectionViewCellHeight = 44.0
  }

  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    //    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(
      HomeTweetCollectionViewCell.self,
      forCellWithReuseIdentifier: "HomeTweetCollectionViewCell")
    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = UIColor.systemBackground
    view.addSubview(collectionView)

    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }
}

extension HomeTabViewController: UICollectionViewDelegate {}

extension HomeTabViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
    -> Int
  {
    guard let tweets else { return 0 }
    return tweets.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell
  {
    let cell =
      collectionView.dequeueReusableCell(
        withReuseIdentifier: "HomeTweetCollectionViewCell", for: indexPath)
      as! HomeTweetCollectionViewCell
    cell.tweet = tweets?[indexPath.row]
    return cell
  }
}

extension HomeTabViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/149
    // - Replace fixed size of HomeTweetCollectionViewCell with a dynamic one.
    return CGSize(
      width: view.frame.width, height: 80)
  }
}

protocol HomeTabViewControllerDelegate: AnyObject {
  func didScrollVertically(xDelta: CGFloat)
}
