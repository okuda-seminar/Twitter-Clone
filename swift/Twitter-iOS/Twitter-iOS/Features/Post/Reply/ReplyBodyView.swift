import UIKit

class ReplyBodyView: UIView {

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/277
  // - Add ReplyEditorSectionView.
  public let inputTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    return textView
  }()

  private let originalUserProfileIcon: UIImage

  private lazy var originalPostView: ReplyOriginalPostView = {
    let view = ReplyOriginalPostView(profileIcon: originalUserProfileIcon)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  public init(originalUserProfileIcon: UIImage) {
    self.originalUserProfileIcon = originalUserProfileIcon
    super.init(frame: .zero)
    setUpSubviews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUpSubviews() {
    addSubview(originalPostView)
    addSubview(inputTextView)

    NSLayoutConstraint.activate([
      originalPostView.topAnchor.constraint(equalTo: topAnchor),
      originalPostView.leadingAnchor.constraint(equalTo: leadingAnchor),
      originalPostView.trailingAnchor.constraint(equalTo: trailingAnchor),

      inputTextView.topAnchor.constraint(equalTo: originalPostView.bottomAnchor),
      inputTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
      inputTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
      inputTextView.heightAnchor.constraint(equalToConstant: 200),
    ])
  }
}
