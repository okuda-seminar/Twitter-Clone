import SwiftUI
import UIKit

class HomeHeaderView: UIView {

  private enum LocalizedString {
    static let forYouButtonTitle = String(localized: "For You")
    static let followingButtonTitle = String(localized: "Following")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    setUpSubviews()
  }

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

    addSubview(stackView)

    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
