import UIKit

class NotificationsTabSelectionView: UIView {

  private enum LayoutConstant {
    static let tabButtonHeight = 44.0
  }

  public let tabButtons: [UIButton] = {
    let buttonTitles = [
      String(localized: "All"),
      String(localized: "Verified"),
      String(localized: "Mentions"),
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

  private let tabButtonsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    return stackView
  }()

  public weak var delegate: NotificationsTabSelectionViewDelegate?

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

      tabButtonsStackView.addArrangedSubview(button)
      NSLayoutConstraint.activate([
        button.topAnchor.constraint(equalTo: tabButtonsStackView.topAnchor),
        button.heightAnchor.constraint(equalToConstant: LayoutConstant.tabButtonHeight),
      ])
    }

    addSubview(tabButtonsStackView)

    NSLayoutConstraint.activate([
      tabButtonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tabButtonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tabButtonsStackView.topAnchor.constraint(equalTo: topAnchor),
      tabButtonsStackView.heightAnchor.constraint(equalToConstant: LayoutConstant.tabButtonHeight),

      bottomAnchor.constraint(equalTo: tabButtonsStackView.bottomAnchor),
    ])
  }
}

protocol NotificationsTabSelectionViewDelegate: AnyObject {
  func didTapTabButton(_ button: UIButton)
}
