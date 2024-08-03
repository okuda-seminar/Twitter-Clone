import SwiftUI
import UIKit

class ReplyKeyboardToolbarView: UIView {

  private enum LayoutConstant {
    static let edgeVerticalPadding: CGFloat = 8.0
    static let edgeHorizontalPadding: CGFloat = 17.0

    static let protectedIconSize: CGFloat = 29.0

    static let textStackViewLeadingPadding: CGFloat = 8.0
  }

  private enum LocalizedString {
    static let warningForProtectedAccount = String(
      localized: "They can't see your Protected reply.")
    static let learnMore = String(localized: "Learn more")
  }

  private let protectedIcon: UIImageView = {
    let view = UIImageView(image: UIImage(systemName: "lock.fill"))
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFit
    view.tintColor = .white
    view.backgroundColor = .brandedBlue
    view.layer.cornerRadius = LayoutConstant.protectedIconSize / 2
    return view
  }()

  private let warningLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = LocalizedString.warningForProtectedAccount
    label.sizeToFit()
    return label
  }()

  private let learnMoreButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    let titleWithUnderLine = NSAttributedString(
      string: LocalizedString.learnMore,
      attributes: [
        .underlineStyle: NSUnderlineStyle.single.rawValue, .underlineColor: UIColor.black,
      ])
    button.setAttributedTitle(titleWithUnderLine, for: .normal)
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpSubviews() {
    backgroundColor = .brandedLightBlueBackground

    let textStackView = UIStackView(arrangedSubviews: [warningLabel, learnMoreButton])
    textStackView.translatesAutoresizingMaskIntoConstraints = false
    textStackView.axis = .vertical
    textStackView.alignment = .leading

    addSubview(protectedIcon)
    addSubview(textStackView)

    NSLayoutConstraint.activate([
      protectedIcon.leadingAnchor.constraint(
        equalTo: leadingAnchor, constant: LayoutConstant.edgeHorizontalPadding),
      protectedIcon.topAnchor.constraint(
        equalTo: topAnchor, constant: LayoutConstant.edgeVerticalPadding),
      protectedIcon.widthAnchor.constraint(equalToConstant: LayoutConstant.protectedIconSize),
      protectedIcon.heightAnchor.constraint(equalToConstant: LayoutConstant.protectedIconSize),

      textStackView.topAnchor.constraint(
        equalTo: topAnchor, constant: LayoutConstant.edgeVerticalPadding),
      textStackView.leadingAnchor.constraint(
        equalTo: protectedIcon.trailingAnchor, constant: LayoutConstant.textStackViewLeadingPadding),
      textStackView.bottomAnchor.constraint(
        equalTo: bottomAnchor, constant: -LayoutConstant.edgeVerticalPadding),
    ])
  }
}
