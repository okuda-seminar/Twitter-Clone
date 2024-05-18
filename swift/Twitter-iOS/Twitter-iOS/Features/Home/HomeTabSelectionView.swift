import SwiftUI
import UIKit

class HomeTabSelectionView: UIView {

  private enum LocalizedString {
    static let forYouButtonTitle = String(localized: "For You")
    static let followingButtonTitle = String(localized: "Following")
  }

  public let forYouButton: HomeTabSelectionButton = {
    let button = HomeTabSelectionButton()
    button.setTitle(LocalizedString.forYouButtonTitle, for: .normal)
    button.isSelected = true
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  public let followingButton: HomeTabSelectionButton = {
    let button = HomeTabSelectionButton()
    button.setTitle(LocalizedString.followingButtonTitle, for: .normal)
    button.isSelected = false
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  public lazy var allButtons: [HomeTabSelectionButton] = {
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

    addSubview(stackView)

    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }
}
