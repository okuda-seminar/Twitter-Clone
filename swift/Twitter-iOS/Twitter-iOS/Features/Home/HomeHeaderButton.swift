import UIKit

class HomeHeaderButton: UIButton {
  override func layoutSubviews() {
    super.layoutSubviews()
    backgroundColor = .systemBackground
    setTitleColor(.black, for: .normal)
  }
}
