import SwiftUI
import UIKit

class UserPostsCollectionViewCell: UICollectionViewCell {
  static let identifier = "CustomCollectionViewCell"

  private var hostingController: UIHostingController<PostCellView>?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupSubView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupSubView() {
    if hostingController == nil {
      hostingController = UIHostingController(rootView: createFakePostCellView())
      hostingController?.view.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview(hostingController!.view)

      NSLayoutConstraint.activate([
        hostingController!.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        hostingController!.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        hostingController!.view.topAnchor.constraint(equalTo: contentView.topAnchor),
        hostingController!.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      ])
    }
  }
}
