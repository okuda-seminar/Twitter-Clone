import UIKit

class TweetDetailViewController: UIViewController {
  private enum LayoutConstant {
    static let edgePadding = 16.0
    static let backButtonSize = 24.0
  }

  private let backButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
    button.tintColor = .black
    button.contentMode = .scaleAspectFit
    button.contentVerticalAlignment = .fill
    button.contentHorizontalAlignment = .fill
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground
    view.addSubview(backButton)

    backButton.addAction(
      .init { _ in
        self.navigationController?.popViewController(animated: true)
      }, for: .touchUpInside)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      backButton.topAnchor.constraint(
        equalTo: layoutGuide.topAnchor, constant: LayoutConstant.edgePadding),
      backButton.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.edgePadding),
      backButton.heightAnchor.constraint(equalToConstant: LayoutConstant.backButtonSize),
      backButton.widthAnchor.constraint(equalToConstant: LayoutConstant.backButtonSize),
    ])
  }
}
