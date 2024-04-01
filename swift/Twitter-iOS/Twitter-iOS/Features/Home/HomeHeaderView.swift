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

  private func setUpSubviews() {
    let forYouButton = HomeHeaderButton()
    forYouButton.setTitle(LocalizedString.forYouButtonTitle, for: .normal)
    forYouButton.translatesAutoresizingMaskIntoConstraints = false

    let followingButton = HomeHeaderButton()
    followingButton.setTitle(LocalizedString.followingButtonTitle, for: .normal)
    followingButton.translatesAutoresizingMaskIntoConstraints = false

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
