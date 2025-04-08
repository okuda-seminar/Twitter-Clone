import UIKit

final class NewMessageEditViewController: UIViewController {
  private enum LocalizedString {
    static let cancelButtonTitle = String(localized: "Cancel")
    static let addressPrefixText = String(localized: "To:")
    static let addressTextFieldPlaceholderText = String(localized: "New message")
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

  private let addressPrefixLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = LocalizedString.addressPrefixText
    label.sizeToFit()
    return label
  }()

  private let addressTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = .clear
    textField.textColor = .black
    textField.textAlignment = .left
    return textField
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground
    view.addSubview(cancelButton)
    view.addSubview(addressPrefixLabel)
    view.addSubview(addressTextField)

    cancelButton.addAction(
      .init { [weak self] _ in
        self?.dismiss(animated: true)
      }, for: .touchUpInside)

    addressTextField.becomeFirstResponder()

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      cancelButton.topAnchor.constraint(
        equalTo: layoutGuide.topAnchor, constant: LayoutConstant.edgePadding),
      cancelButton.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.edgePadding),

      addressPrefixLabel.topAnchor.constraint(
        equalTo: cancelButton.bottomAnchor, constant: 12),
      addressPrefixLabel.leadingAnchor.constraint(equalTo: cancelButton.leadingAnchor),

      addressTextField.topAnchor.constraint(equalTo: addressPrefixLabel.topAnchor),
      addressTextField.leadingAnchor.constraint(
        equalTo: addressPrefixLabel.trailingAnchor,
        constant: 4),
      addressTextField.trailingAnchor.constraint(
        lessThanOrEqualTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),
    ])
  }
}
