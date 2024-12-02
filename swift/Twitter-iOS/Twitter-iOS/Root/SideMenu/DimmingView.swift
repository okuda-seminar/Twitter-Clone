import UIKit

class DimmingView: UIView {

  // MARK: - Closure to Handle Tap Events

  public var onTapAction: (() -> Void)?

  // MARK: - Initializer

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpBackground()
    addTapGesture()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private API

  private func setUpBackground() {
    backgroundColor = .black
    alpha = 0.0
  }

  private func addTapGesture() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    addGestureRecognizer(tapGestureRecognizer)
  }

  // MARK: - Gesture Handling

  @objc
  private func handleTap() {
    onTapAction?()
  }
}
