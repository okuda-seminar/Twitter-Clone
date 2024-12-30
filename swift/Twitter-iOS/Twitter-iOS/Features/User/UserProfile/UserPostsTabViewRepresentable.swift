import SwiftUI
import UIKit

struct UserPostsTabViewRepresentable: UIViewRepresentable {
  @Binding var isScrollEnabled: Bool

  func makeUIView(context: Context) -> some UICollectionView {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.dataSource = context.coordinator
    collectionView.delegate = context.coordinator
    collectionView.showsVerticalScrollIndicator = false
    collectionView.register(
      UserPostsCollectionViewCell.self,
      forCellWithReuseIdentifier: UserPostsCollectionViewCell.identifier)
    return collectionView
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {
    uiView.isScrollEnabled = isScrollEnabled
  }

  func makeCoordinator() -> UserPostsTabViewCoordinator {
    Coordinator(isScrollEnabled: $isScrollEnabled)
  }
}

#Preview {
  UserPostsTabViewRepresentable(isScrollEnabled: .constant(true))
}
