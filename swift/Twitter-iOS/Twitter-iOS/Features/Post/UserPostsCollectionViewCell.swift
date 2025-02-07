import SwiftUI
import UIKit

/// The custom collection view cell that displays a post cell view in the user profile.
class UserPostsCollectionViewCell: UICollectionViewCell {

  /// The reuse identifier for the custom collection view cell.
  static let identifier = "UserPostsCollectionViewCell"

  /// The hosting controller that wraps the post cell view to embed a SwiftUI view inside a UIKit collection view cell.
  private lazy var hostingController: UIHostingController = {
    let fakePostCellView = createFakePostCellView()
    let hostingController = UIHostingController(rootView: fakePostCellView)
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    return hostingController
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Sets up the subviews for the collection view cell.
  private func setUpSubviews() {
    contentView.backgroundColor = .systemBackground

    contentView.addSubview(hostingController.view)

    NSLayoutConstraint.activate([
      hostingController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      hostingController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }
}
