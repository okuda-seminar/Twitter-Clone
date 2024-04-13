import UIKit


protocol NotificationsHeaderViewDelegate {
  func didTapTabButton(_ button: UIButton)
}

class NotificationsHeaderView: UIView {
  private enum LayoutConstant {
    static let tabButtonHeight = 44.0
  }

  public let tabButtons: [UIButton] = {
    let buttonTitles = [
      String(localized: "All"),
      String(localized: "Verified"),
      String(localized: "Mentions")
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

  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    return stackView
  }()

  public var delegate: NotificationsHeaderViewDelegate?

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
