import SwiftUI
import UIKit

class HomeHeaderView: UIView {
  
  private enum LayoutConstant {
    static let settingsEntryPointButtonSize = 28.0
    static let edgeHorizontalPadding = 16.0
  }

  private enum LocalizedString {
    static let forYouButtonTitle = String(localized: "For You")
    static let followingButtonTitle = String(localized: "Following")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public let settingsEntryPointButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "gear"), for: .normal)
    button.tintColor = .black
    button.imageView?.contentMode = .scaleAspectFit
    button.contentHorizontalAlignment = .fill
    button.contentVerticalAlignment = .fill
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

  public lazy var allButtons: [HomeHeaderButton]  = {
    return [forYouButton, followingButton]
  }()

  private func setUpSubviews() {
    let stackView = UIStackView(arrangedSubviews: [forYouButton, followingButton])
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false

    addSubview(settingsEntryPointButton)
    addSubview(stackView)

    NSLayoutConstraint.activate([
      settingsEntryPointButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutConstant.edgeHorizontalPadding),
      settingsEntryPointButton.topAnchor.constraint(equalTo: topAnchor),
      settingsEntryPointButton.widthAnchor.constraint(equalToConstant: LayoutConstant.settingsEntryPointButtonSize),
      settingsEntryPointButton.heightAnchor.constraint(equalToConstant: LayoutConstant.settingsEntryPointButtonSize),

      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.topAnchor.constraint(equalTo: settingsEntryPointButton.bottomAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
