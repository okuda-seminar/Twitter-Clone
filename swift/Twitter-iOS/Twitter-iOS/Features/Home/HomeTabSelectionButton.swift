import UIKit

protocol HomeTabSelectionButtonDelegate: AnyObject {
  func didTapHomeTabSelectionButton(selectedButton: HomeTabSelectionButton)
}

class HomeTabSelectionButton: UIButton {

  public var tabID: String?
  public weak var delegate: HomeTabSelectionButtonDelegate?

  override func layoutSubviews() {
    super.layoutSubviews()
    backgroundColor = .systemBackground
    setTitleColor(.black, for: .selected)
    setTitleColor(.placeholderText, for: .normal)
    setTitleColor(.gray, for: .disabled)

    addTarget(self, action: #selector(didTap), for: .touchUpInside)
  }

  @objc
  public func didTap() {
    self.delegate?.didTapHomeTabSelectionButton(selectedButton: self)
  }
}
