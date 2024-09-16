import UIKit

final class NewMessageEntrypointButtonController: UIViewController {
  public enum NewMessageButtonType: Int {
    case newMessageEntrypointButton
    case writeMessageButton
  }

  public let buttonType: NewMessageButtonType

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  init(buttonType: NewMessageButtonType) {
    self.buttonType = buttonType
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpSubviews() {
    let button =
      switch buttonType {
      case .newMessageEntrypointButton: NewMessageEntrypointButton()
      case .writeMessageButton: WriteMessageButton()
      }
    button.addAction(
      .init { [weak self] _ in
        let newMessageEditViewController = NewMessageEditViewController()
        self?.present(newMessageEditViewController, animated: true)
      }, for: .touchUpInside)
    view = button
  }
}

final class NewMessageEntrypointButton: UIButton {
  private enum LayoutConstant {
    static let buttonSize: CGFloat = 44.0
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupButton()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupButton() {
    setImage(UIImage(systemName: "envelope"), for: .normal)
    imageView?.contentMode = .scaleAspectFit
    layer.cornerRadius = LayoutConstant.buttonSize / 2
    translatesAutoresizingMaskIntoConstraints = false
    tintColor = .white
    backgroundColor = .brandedBlue

    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: LayoutConstant.buttonSize),
      heightAnchor.constraint(equalToConstant: LayoutConstant.buttonSize),
    ])
  }
}

final class WriteMessageButton: UIButton {
  private enum LayoutConstant {
    static let buttonWidth: CGFloat = 200.0
    static let buttonHeight: CGFloat = 55.0
  }

  private enum LocalizedString {
    static let buttonTitle = String(localized: "Write a message")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupButton()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupButton() {
    let titleWithUnderLine = NSAttributedString(
      string: LocalizedString.buttonTitle,
      attributes: [
        .underlineStyle: NSUnderlineStyle.single.rawValue, .underlineColor: UIColor.white,
      ])
    setAttributedTitle(titleWithUnderLine, for: .normal)
    titleLabel?.textColor = .white

    layer.cornerRadius = LayoutConstant.buttonHeight / 2
    backgroundColor = .brandedBlue
    translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: LayoutConstant.buttonWidth),
      heightAnchor.constraint(equalToConstant: LayoutConstant.buttonHeight),
    ])
  }
}
