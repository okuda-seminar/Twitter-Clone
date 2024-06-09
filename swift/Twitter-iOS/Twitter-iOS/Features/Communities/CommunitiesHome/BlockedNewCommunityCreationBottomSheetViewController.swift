import UIKit

final class BlockedNewCommunityCreationBottomSheetViewController: UIViewController {
  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/262
  // - Refactor BlockedNewCommunityCreationBottomSheetViewController using SwiftUI and polish its UI.
  private enum LocalizedString {
    static let headlineText = String(localized: "Unblock creating a Community with X Premium")
    static let dismissButtonText = String(localized: "Maybe later")
  }

  private enum LayoutConstant {
    static let edgeHorizontalPadding = 16.0
    static let headlineLabelTopPadding = 12.0
    static let dismissButtonTopPadding = 8.0
    static let dismissButtonBottomPadding = 24.0
  }

  private let headlineLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = LocalizedString.headlineText
    label.sizeToFit()
    return label
  }()

  public let dismissButton: UIButton = {
    let button = UIButton()
    let titleWithUnderLine = NSAttributedString(
      string: LocalizedString.dismissButtonText,
      attributes: [
        .underlineStyle: NSUnderlineStyle.single.rawValue, .underlineColor: UIColor.black,
      ])
    button.setAttributedTitle(titleWithUnderLine, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.addSubview(headlineLabel)
    view.addSubview(dismissButton)

    view.backgroundColor = .systemBackground

    NSLayoutConstraint.activate([
      headlineLabel.leadingAnchor.constraint(
        equalTo: view.leadingAnchor, constant: LayoutConstant.edgeHorizontalPadding),
      headlineLabel.trailingAnchor.constraint(
        equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeHorizontalPadding),
      headlineLabel.topAnchor.constraint(
        equalTo: view.topAnchor, constant: LayoutConstant.headlineLabelTopPadding),

      dismissButton.leadingAnchor.constraint(
        equalTo: view.leadingAnchor, constant: LayoutConstant.edgeHorizontalPadding),
      dismissButton.trailingAnchor.constraint(
        equalTo: view.trailingAnchor, constant: -LayoutConstant.edgeHorizontalPadding),
      dismissButton.topAnchor.constraint(
        equalTo: headlineLabel.bottomAnchor, constant: LayoutConstant.dismissButtonTopPadding),
      dismissButton.bottomAnchor.constraint(
        equalTo: view.bottomAnchor, constant: -LayoutConstant.dismissButtonBottomPadding),
    ])

    dismissButton.addAction(
      .init { _ in
        self.dismiss(animated: true)
      }, for: .touchUpInside)
  }
}
