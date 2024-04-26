import UIKit

final class NewTweetEditViewController: UIViewController {
  private enum LocalizedString {
    static let cancelButtonTitle = String(localized: "Cancel")
  }

  private enum LayoutConstant {
    static let edgePadding = 16.0
  }

  private let cancelButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .black
    let titleWithUnderLine = NSAttributedString(
      string: LocalizedString.cancelButtonTitle,
      attributes: [
        .underlineStyle: NSUnderlineStyle.single.rawValue, .underlineColor: UIColor.black,
      ])
    button.setAttributedTitle(titleWithUnderLine, for: .normal)
    button.sizeToFit()
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground
    view.addSubview(cancelButton)

    cancelButton.addAction(.init { _ in
      self.dismiss(animated: true)
    }, for: .touchUpInside)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      cancelButton.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: LayoutConstant.edgePadding),
      cancelButton.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.edgePadding),
    ])
  }
}
