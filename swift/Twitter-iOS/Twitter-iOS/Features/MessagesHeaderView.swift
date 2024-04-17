import UIKit

class MessagesHeaderView: UIView {

  private enum LayoutConstant {
    static let settingsEntryButtonSize = 24.0
  }

  private enum LocalizedString {
    static let title = String(localized: "Messages")
  }
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = LocalizedString.title
    label.textColor = .black
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
    addSubview(titleLabel)
    addSubview(settingsEntryButton)

    titleLabel.sizeToFit()

    NSLayoutConstraint.activate([
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

      settingsEntryButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      settingsEntryButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      settingsEntryButton.widthAnchor.constraint(equalToConstant: LayoutConstant.settingsEntryButtonSize),
      settingsEntryButton.heightAnchor.constraint(equalToConstant: LayoutConstant.settingsEntryButtonSize),
    ])
  }
}
