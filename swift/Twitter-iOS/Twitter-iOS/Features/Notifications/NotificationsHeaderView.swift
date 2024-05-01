import UIKit

class NotificationsHeaderView: UIView {

  private enum LayoutConstant {
    static let edgeTopPadding = 8.0
    static let horizontalPadding = 16.0
    static let profileIconButtonSize = 28.0
    static let titleLabelVerticalPadding = 8.0
    static let settingsEntryPointButtonSize = 28.0
    static let tabButtonHeight = 44.0
  }

  private enum LocalizedString {
    static let titleText = String(localized: "Notifications")
  }

  public let profileIconButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "person.circle.fill"), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .black
    button.imageView?.contentMode = .scaleAspectFit
    button.contentHorizontalAlignment = .fill
    button.contentVerticalAlignment = .fill
    return button
  }()

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.tintColor = .black
    label.text = LocalizedString.titleText
    label.sizeToFit()
    return label
  }()

  public let settingsEntryPointButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "gear"), for: .normal)
    button.contentMode = .scaleAspectFit
    button.contentHorizontalAlignment = .fill
    button.contentVerticalAlignment = .fill
    button.tintColor = .black
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  public let tabButtons: [UIButton] = {
    let buttonTitles = [
      String(localized: "All"),
      String(localized: "Verified"),
      String(localized: "Mentions"),
    ]
    var buttons: [UIButton] = []
    for title in buttonTitles {
      let button = UIButton()
      button.translatesAutoresizingMaskIntoConstraints = false
      button.setTitleColor(.black, for: .selected)
      button.setTitleColor(.placeholderText, for: .normal)
      button.setTitleColor(.gray, for: .disabled)
      button.setTitle(title, for: .normal)
      button.backgroundColor = .clear
      button.sizeToFit()
      buttons.append(button)
    }
    return buttons
  }()

  private let tabButtonsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    return stackView
  }()

  public weak var delegate: NotificationsHeaderViewDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpSubviews() {
    for button in tabButtons {
      button.isSelected = button == tabButtons[0]
      button.addAction(.init { _ in self.delegate?.didTapTabButton(button) }, for: .touchUpInside)

      tabButtonsStackView.addArrangedSubview(button)
      NSLayoutConstraint.activate([
        button.topAnchor.constraint(equalTo: tabButtonsStackView.topAnchor),
        button.heightAnchor.constraint(equalToConstant: LayoutConstant.tabButtonHeight),
      ])
    }

    addSubview(profileIconButton)
    addSubview(titleLabel)
    addSubview(settingsEntryPointButton)
    addSubview(tabButtonsStackView)

    NSLayoutConstraint.activate([
      profileIconButton.leadingAnchor.constraint(
        equalTo: leadingAnchor, constant: LayoutConstant.horizontalPadding),
      profileIconButton.topAnchor.constraint(
        equalTo: topAnchor, constant: LayoutConstant.edgeTopPadding),
      profileIconButton.widthAnchor.constraint(
        equalToConstant: LayoutConstant.profileIconButtonSize),
      profileIconButton.heightAnchor.constraint(
        equalToConstant: LayoutConstant.profileIconButtonSize),

      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: profileIconButton.centerYAnchor),
      titleLabel.topAnchor.constraint(
        equalTo: topAnchor, constant: LayoutConstant.titleLabelVerticalPadding),

      settingsEntryPointButton.trailingAnchor.constraint(
        equalTo: trailingAnchor, constant: -LayoutConstant.horizontalPadding),
      settingsEntryPointButton.topAnchor.constraint(equalTo: profileIconButton.topAnchor),
      settingsEntryPointButton.widthAnchor.constraint(
        equalToConstant: LayoutConstant.settingsEntryPointButtonSize),
      settingsEntryPointButton.heightAnchor.constraint(
        equalToConstant: LayoutConstant.settingsEntryPointButtonSize),

      tabButtonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tabButtonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tabButtonsStackView.topAnchor.constraint(
        equalTo: titleLabel.bottomAnchor, constant: LayoutConstant.titleLabelVerticalPadding),
      tabButtonsStackView.heightAnchor.constraint(equalToConstant: LayoutConstant.tabButtonHeight),

      bottomAnchor.constraint(equalTo: tabButtonsStackView.bottomAnchor),
    ])
  }
}

protocol NotificationsHeaderViewDelegate: AnyObject {
  func didTapTabButton(_ button: UIButton)
}
