import UIKit

final class NewTweetEditViewController: UIViewController {
  private enum LocalizedString {
    static let cancelButtonTitle = String(localized: "Cancel")
    static let tweetTextViewPlaceholderText = String(localized: "What's happening?")
  }

  private enum LayoutConstant {
    static let edgePadding = 16.0
    static let tweetTextViewTopPadding = 12.0
    static let tweetTextViewMinimumHeight = 48.0
  }

  private var tweetTextViewHightConstraint: NSLayoutConstraint?

  private let cancelButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .black
    let titleWithUnderLine = NSAttributedString(
      string: LocalizedString.cancelButtonTitle,
      attributes: [
        .underlineStyle: NSUnderlineStyle.single.rawValue, .underlineColor: UIColor.black,
      ])
    button.setAttributedTitle(titleWithUnderLine, for: .normal)
    button.sizeToFit()
    return button
  }()

  private let tweetTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.backgroundColor = .clear
    textView.textColor = .black
    textView.isEditable = true
    return textView
  }()

  private let tweetTextViewPlaceHolder: UITextView = {
    let placeHolder = UITextView()
    placeHolder.translatesAutoresizingMaskIntoConstraints = false
    placeHolder.text = LocalizedString.tweetTextViewPlaceholderText
    placeHolder.textColor = .lightGray
    placeHolder.isEditable = false
    placeHolder.isUserInteractionEnabled = false
    placeHolder.sizeToFit()
    return placeHolder
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.backgroundColor = .systemBackground
    view.addSubview(cancelButton)
    view.addSubview(tweetTextViewPlaceHolder)
    view.addSubview(tweetTextView)

    cancelButton.addAction(.init { _ in
      self.dismiss(animated: true)
    }, for: .touchUpInside)

    tweetTextView.becomeFirstResponder()
    tweetTextView.delegate = self

    let layoutGuide = view.safeAreaLayoutGuide
    let tweetTextViewPlaceHolderHeight = tweetTextViewPlaceHolder.frame.height
    tweetTextViewHightConstraint = tweetTextView.heightAnchor.constraint(equalToConstant: tweetTextViewPlaceHolderHeight)
    guard let tweetTextViewHightConstraint else { return }
    NSLayoutConstraint.activate([
      cancelButton.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: LayoutConstant.edgePadding),
      cancelButton.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.edgePadding),

      tweetTextView.leadingAnchor.constraint(equalTo: cancelButton.leadingAnchor),
      tweetTextView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),
      tweetTextView.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: LayoutConstant.tweetTextViewTopPadding),
      tweetTextViewHightConstraint,

      tweetTextViewPlaceHolder.topAnchor.constraint(equalTo: tweetTextView.topAnchor),
      tweetTextViewPlaceHolder.leadingAnchor.constraint(equalTo: tweetTextView.leadingAnchor),
      tweetTextViewPlaceHolder.trailingAnchor.constraint(equalTo: tweetTextView.trailingAnchor),
      tweetTextViewPlaceHolder.heightAnchor.constraint(equalToConstant: tweetTextViewPlaceHolderHeight)
    ])
  }
}

extension NewTweetEditViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    tweetTextViewPlaceHolder.isHidden = !textView.text.isEmpty
    let height = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude)).height
    tweetTextViewHightConstraint?.constant = height
  }
}
