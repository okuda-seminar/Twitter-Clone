import UIKit

class ReplyHeaderView: UIView {

  public let dismissalButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    let titleWithUnderLine = NSAttributedString(
      string: LocalizedString.dismissalButtonText,
      attributes: [
        .underlineStyle: NSUnderlineStyle.single.rawValue, .underlineColor: UIColor.black,
      ])
    button.setAttributedTitle(titleWithUnderLine, for: .normal)
    button.layer.cornerRadius = LayoutConstant.buttonHeight / 2
    return button
  }()

  public let postButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(LocalizedString.postButtonText, for: .normal)
    button.tintColor = .white
    button.backgroundColor = .brandedBlue
    button.layer.cornerRadius = LayoutConstant.buttonHeight / 2
    return button
  }()

  private enum LayoutConstant {
    static let buttonHeight: CGFloat = 44.0
    static let buttonWidth: CGFloat = 72.0

    static let edgeHorizontalPadding: CGFloat = 16.0
    static let edgeBottomPadding: CGFloat = 12.0
  }

  private enum LocalizedString {
    static let dismissalButtonText = String(localized: "Cancel")
    static let postButtonText = String(localized: "Post")
    static let inputPlaceholder = String(localized: "Post your reply")

    static let deleteButtonText = String(localized: "Delete")
    static let saveDraftButtonText = String(localized: "Save draft")
  }

  private let dividerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.tintColor = .black
    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpSubviews() {
    let buttonStackView = UIStackView(arrangedSubviews: [dismissalButton, postButton])
    buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    buttonStackView.axis = .horizontal
    buttonStackView.distribution = .equalSpacing

    addSubview(buttonStackView)
    addSubview(dividerView)

    NSLayoutConstraint.activate([
      dismissalButton.heightAnchor.constraint(equalToConstant: LayoutConstant.buttonHeight),
      dismissalButton.widthAnchor.constraint(equalToConstant: LayoutConstant.buttonWidth),
      postButton.heightAnchor.constraint(equalToConstant: LayoutConstant.buttonHeight),
      postButton.widthAnchor.constraint(equalToConstant: LayoutConstant.buttonWidth),

      buttonStackView.topAnchor.constraint(equalTo: topAnchor),
      buttonStackView.leadingAnchor.constraint(
        equalTo: leadingAnchor, constant: LayoutConstant.edgeHorizontalPadding),
      buttonStackView.heightAnchor.constraint(equalToConstant: LayoutConstant.buttonHeight),
      buttonStackView.trailingAnchor.constraint(
        equalTo: trailingAnchor, constant: -LayoutConstant.edgeHorizontalPadding),

      dividerView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor),
      dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      dividerView.bottomAnchor.constraint(
        equalTo: bottomAnchor, constant: -LayoutConstant.edgeBottomPadding),
      dividerView.heightAnchor.constraint(equalToConstant: 1),
      dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }
}
