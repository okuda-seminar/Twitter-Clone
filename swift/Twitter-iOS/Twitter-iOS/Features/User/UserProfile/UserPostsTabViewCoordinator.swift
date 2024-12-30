import SwiftUI
import UIKit

class UserPostsTabViewCoordinator: NSObject, UICollectionViewDataSource {
  @Binding var isScrollEnabled: Bool

  init(isScrollEnabled: Binding<Bool>) {
    _isScrollEnabled = isScrollEnabled
  }

  private enum LayoutConstant {
    static let cellHeight: CGFloat = 238.17
    static let minimumLineSpacing: CGFloat = 0.0
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
    -> Int
  {
    return 30
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

extension UserPostsTabViewCoordinator: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width, height: LayoutConstant.cellHeight)
  }

  func collectionView(
    _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return LayoutConstant.minimumLineSpacing
  }
}

extension UserPostsTabViewCoordinator: UIScrollViewDelegate {

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y <= 0 {
      isScrollEnabled = false
    }
  }
}
