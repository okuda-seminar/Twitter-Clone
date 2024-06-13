import UIKit

class ReplyBodyView: UIView {
  public let inputTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    return textView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpSubviews() {
    addSubview(inputTextView)

    NSLayoutConstraint.activate([
      inputTextView.topAnchor.constraint(equalTo: topAnchor),
      inputTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
      inputTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
      inputTextView.heightAnchor.constraint(equalToConstant: 200),
    ])
  }
}
