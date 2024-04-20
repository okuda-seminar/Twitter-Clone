import UIKit

class TimelineSettingsHeaderView: UIView {
  private enum LocalizedString {
    static let title = String(localized: "Timeline settings")
    static let dismissButtonText = String(localized: "Done")
  }

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = LocalizedString.title
    label.sizeToFit()
    return label
  }()

  public let dismissButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    let titleWithUnderLine = NSAttributedString(
      string: LocalizedString.dismissButtonText,
      attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue,.underlineColor: UIColor.black])
    button.setAttributedTitle(titleWithUnderLine, for: .normal)
    button.sizeToFit()
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
    addSubview(dismissButton)

    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

      dismissButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
      dismissButton.trailingAnchor.constraint(equalTo: trailingAnchor),
    ])
  }
}
