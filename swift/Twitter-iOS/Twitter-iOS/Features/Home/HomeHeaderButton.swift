import UIKit

protocol HomeHeaderButtonDelegate: AnyObject {
  func didTapHomeHeaderButton(selectedButton: HomeHeaderButton)
}

class HomeHeaderButton: UIButton {

  public var tabID: String?
  public weak var delegate: HomeHeaderButtonDelegate?

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
    self.delegate?.didTapHomeHeaderButton(selectedButton: self)
  }
}
