import UIKit

class MessagesHeaderView: UIView {

  private enum LayoutConstant {
    static let edgeTopPadding = 8.0
    static let profileIconButtonSize = 28.0
    static let titleLabelTopPadding = 8.0
    static let settingsEntryButtonSize = 28.0
  }

  private enum LocalizedString {
    static let title = String(localized: "Messages")
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
    label.text = LocalizedString.title
    label.textColor = .black
    label.sizeToFit()
    return label
  }()

  private let settingsEntryButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "gear"), for: .normal)
    button.contentMode = .scaleAspectFit
    button.contentHorizontalAlignment = .fill
    button.contentVerticalAlignment = .fill
    button.tintColor = .black
    button.translatesAutoresizingMaskIntoConstraints = false
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
    addSubview(profileIconButton)
    addSubview(titleLabel)
    addSubview(settingsEntryButton)

    NSLayoutConstraint.activate([
      profileIconButton.leadingAnchor.constraint(equalTo: leadingAnchor),
      profileIconButton.topAnchor.constraint(equalTo: topAnchor, constant: LayoutConstant.edgeTopPadding),
      profileIconButton.widthAnchor.constraint(equalToConstant: LayoutConstant.profileIconButtonSize),
      profileIconButton.heightAnchor.constraint(equalToConstant: LayoutConstant.profileIconButtonSize),

      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutConstant.titleLabelTopPadding),
      titleLabel.centerYAnchor.constraint(equalTo: profileIconButton.centerYAnchor),
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

      settingsEntryButton.topAnchor.constraint(equalTo: profileIconButton.topAnchor),
      settingsEntryButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      settingsEntryButton.widthAnchor.constraint(equalToConstant: LayoutConstant.settingsEntryButtonSize),
      settingsEntryButton.heightAnchor.constraint(equalToConstant: LayoutConstant.settingsEntryButtonSize),
    ])
  }
}
