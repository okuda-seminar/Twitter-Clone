import UIKit

class NotificationsHeaderView: UIView {
  private enum LayoutConstant {
    static let tabButtonHeight = 44.0
  }

  private let tabButtonTitle: [String] = {
    return [
      String(localized: "All"),
      String(localized: "Verified"),
      String(localized: "Mentions")
    ]
  }()

  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    return stackView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpSubviews() {
    for title in tabButtonTitle {
      let button = UIButton()
      button.setTitle(title, for: .normal)
      button.translatesAutoresizingMaskIntoConstraints = false
      button.backgroundColor = .clear
      button.setTitleColor(.black, for: .normal)
      button.sizeToFit()

      stackView.addArrangedSubview(button)
      NSLayoutConstraint.activate([
        button.topAnchor.constraint(equalTo: stackView.topAnchor),
        button.heightAnchor.constraint(equalToConstant: LayoutConstant.tabButtonHeight),
      ])
    }

    addSubview(stackView)

    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.heightAnchor.constraint(equalToConstant: LayoutConstant.tabButtonHeight),
    ])
  }
}
