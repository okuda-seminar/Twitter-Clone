import UIKit

class TweetDetailViewController: UIViewController {
  private enum LayoutConstant {
    static let title = String(localized: "Post")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground
    navigationItem.title = LayoutConstant.title
  }
}
