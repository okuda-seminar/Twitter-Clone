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

extension HomeTabViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell =
      collectionView.dequeueReusableCell(
        withReuseIdentifier: "HomeTweetCollectionViewCell", for: indexPath)
      as! HomeTweetCollectionViewCell
    delegate?.didTapTweetCell(cell)
  }
}

extension HomeTabViewController: UIContextMenuInteractionDelegate {
  private enum LocalizedLongTapActionString {
    static let unfollow = String(localized: "Unfollow")
    static let addOrRemoveFromLists = String(localized: "Add/remove from Lists")
    static let block = String(localized: "Block")
    static let mute = String(localized: "Mute")
    static let reportPost = String(localized: "Report post")
  }

  func contextMenuInteraction(
    _ interaction: UIContextMenuInteraction,
    configurationForMenuAtLocation location: CGPoint
  ) -> UIContextMenuConfiguration? {
    return UIContextMenuConfiguration(
      identifier: nil,
      previewProvider: nil,
      actionProvider: { suggestedActions in
        let unfollowAction = UIAction(
          title: LocalizedLongTapActionString.unfollow,
          image: UIImage(systemName: "person.fill.xmark")
        ) { action in
          let userName = "@mockUserName"
          UserService.sharedInstance.unfollowUser(userName) { success in
            if success {
              let bannerController = BannerController(message: "\(userName) has been unfollowed")
              bannerController.show(on: MainRootViewController.sharedInstance)
            }
          }
        }

        let addOrRemoveFromListsAction = UIAction(
          title: LocalizedLongTapActionString.addOrRemoveFromLists,
          image: UIImage(systemName: "list.clipboard")
        ) { action in
        }

        let muteAction = UIAction(
          title: LocalizedLongTapActionString.mute,
          image: UIImage(systemName: "speaker.slash")
        ) { action in
          let userName = "@mockUserName"
          UserService.sharedInstance.muteUser(userName) { success in
            if success {
              let bannerController = BannerController(message: "\(userName) has been muted")
              bannerController.show(on: MainRootViewController.sharedInstance)
            }
          }
        }

        let blockAction = UIAction(
          title: LocalizedLongTapActionString.block,
          image: UIImage(systemName: "xmark.circle")
        ) { action in
          let userName = "@mockUserName"
          UserService.sharedInstance.blockUser(userName) { success in
            if success {
              let userName = "@mockUserName"
              let bannerController = BannerController(message: "\(userName) has been blocked")
              bannerController.show(on: MainRootViewController.sharedInstance)
            }
          }
        }

        let reportAction = UIAction(
          title: LocalizedLongTapActionString.reportPost,
          image: UIImage(systemName: "flag")
        ) { action in
        }

        return UIMenu(
          title: "Select Action",
          children: [
            unfollowAction, addOrRemoveFromListsAction, muteAction, blockAction, reportAction,
          ])
      })
  }
}

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
    cell.userIconButton.addAction(
      .init { _ in
        self.delegate?.didTapUserIconInCell(cell)
      }, for: .touchUpInside)
    let interaction = UIContextMenuInteraction(delegate: self)
    cell.addInteraction(interaction)

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
  func didTapTweetCell(_ cell: HomeTweetCollectionViewCell)
  func didTapUserIconInCell(_ cell: HomeTweetCollectionViewCell)
}
