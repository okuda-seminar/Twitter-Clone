import SwiftUI
import UIKit

class HomeHeaderView: UIView {

  private enum LayoutConstant {
    static let edgeTopPadding = 8.0
    static let edgeHorizontalPadding = 16.0
    static let profileIconButtonSize = 28.0
    static let settingsEntryPointButtonSize = 28.0
  }

  private enum LocalizedString {
    static let forYouButtonTitle = String(localized: "For You")
    static let followingButtonTitle = String(localized: "Following")
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

  public let forYouButton: HomeHeaderButton = {
    let button = HomeHeaderButton()
    button.setTitle(LocalizedString.forYouButtonTitle, for: .normal)
    button.isSelected = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  public let followingButton: HomeHeaderButton = {
    let button = HomeHeaderButton()
    button.setTitle(LocalizedString.followingButtonTitle, for: .normal)
    button.isSelected = false
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  public lazy var allButtons: [HomeHeaderButton] = {
    return [forYouButton, followingButton]
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpSubviews() {
    let stackView = UIStackView(arrangedSubviews: [forYouButton, followingButton])
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false

    addSubview(profileIconButton)
    addSubview(settingsEntryPointButton)
    addSubview(stackView)

    NSLayoutConstraint.activate([
      profileIconButton.leadingAnchor.constraint(
        equalTo: leadingAnchor, constant: LayoutConstant.edgeHorizontalPadding),
      profileIconButton.topAnchor.constraint(
        equalTo: topAnchor, constant: LayoutConstant.edgeTopPadding),
      profileIconButton.widthAnchor.constraint(
        equalToConstant: LayoutConstant.profileIconButtonSize),
      profileIconButton.heightAnchor.constraint(
        equalToConstant: LayoutConstant.profileIconButtonSize),

      settingsEntryPointButton.trailingAnchor.constraint(
        equalTo: trailingAnchor, constant: -LayoutConstant.edgeHorizontalPadding),
      settingsEntryPointButton.topAnchor.constraint(equalTo: profileIconButton.topAnchor),
      settingsEntryPointButton.widthAnchor.constraint(
        equalToConstant: LayoutConstant.settingsEntryPointButtonSize),
      settingsEntryPointButton.heightAnchor.constraint(
        equalToConstant: LayoutConstant.settingsEntryPointButtonSize),

      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.topAnchor.constraint(equalTo: settingsEntryPointButton.bottomAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }
}
