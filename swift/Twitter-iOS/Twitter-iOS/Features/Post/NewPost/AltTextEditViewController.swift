import SwiftUI
import UIKit

class AltTextEditViewController: UIViewController {

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/401
  // - Polish AltTextEditView UI and Enable Mutual Data Transition with NewPostEditDataSource.

  private enum LocalizedString {
    static let titleText = String(localized: "Write alt text")
    static let dismissalButtonText = String(localized: "Cancel")
    static let saveButtonText = String(localized: "Save")
    static let helpButtonText = String(localized: "What's an image description?")
  }

  private enum LayoutConstant {
    static let headlineFontSize: CGFloat = 20.0
    static let buttonsAndTitleStackViewTopPadding: CGFloat = 10.0
    static let scrollViewTopPadding: CGFloat = 10.0
    static let textViewTopPadding: CGFloat = 10.0
    static let helpButtonAndCountStackViewTopPadding: CGFloat = 10.0
    static let leadingPadding: CGFloat = 15.0
    static let trailingPadding: CGFloat = -15.0
    static let imageHeight: CGFloat = 150.0
    static let textViewHeight: CGFloat = 200.0
  }

  @ObservedObject private var dataSource: NewPostEditDataSource

  init(dataSource: NewPostEditDataSource) {
    self.dataSource = dataSource
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private let viewTitle: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = LocalizedString.titleText
    label.font = UIFont.systemFont(ofSize: LayoutConstant.headlineFontSize, weight: .heavy)
    label.textColor = .white
    return label
  }()

  private let dismissalButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(LocalizedString.dismissalButtonText, for: .normal)
    return button
  }()

  private let saveButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(LocalizedString.saveButtonText, for: .normal)
    return button
  }()

  private let inputTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.textColor = .white
    textView.backgroundColor = .black
    return textView
  }()

  private let selectedImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(systemName: "apple.logo"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let helpButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(LocalizedString.helpButtonText, for: .normal)
    button.setTitleColor(.brandedBlue, for: .normal)
    return button
  }()

  private lazy var altTextCountLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .gray
    label.text = "\(dataSource.altText.count)/1000"
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubViews()
  }

  /// The reason we're choosing UIKit instead of SwiftUi here.
  /// 1.Although it is easier to create a View in SwiftUI, SwiftUI doesn’t support becomeFirstResponder,
  /// and it is easier to implement that functionality with UIKit.
  /// 2. SwiftUI ScrollView is not compatible with NSLayoutConstant and this makes it harder to align its height with the keyboardLayoutGuide
  /// and could impair UX.
  private func setUpSubViews() {
    view.backgroundColor = .black

    let buttonsAndTitleStackView = UIStackView(arrangedSubviews: [
      dismissalButton, viewTitle, saveButton,
    ])
    buttonsAndTitleStackView.translatesAutoresizingMaskIntoConstraints = false
    buttonsAndTitleStackView.axis = .horizontal
    buttonsAndTitleStackView.distribution = .equalSpacing

    let helpButtonAndCountStackView = UIStackView(arrangedSubviews: [helpButton, altTextCountLabel])
    helpButtonAndCountStackView.translatesAutoresizingMaskIntoConstraints = false
    helpButtonAndCountStackView.axis = .horizontal
    helpButtonAndCountStackView.distribution = .equalSpacing

    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(selectedImageView)
    scrollView.addSubview(inputTextView)
    scrollView.addSubview(helpButtonAndCountStackView)

    view.addSubview(buttonsAndTitleStackView)
    view.addSubview(scrollView)

    dismissalButton.addAction(
      .init { _ in
        self.dismiss(animated: true)
      }, for: .touchUpInside)

    inputTextView.becomeFirstResponder()

    let layoutGuide = view.safeAreaLayoutGuide
    let keyboardLayoutGuide = view.keyboardLayoutGuide
    let scrollViewFrameLayoutGuide = scrollView.frameLayoutGuide

    NSLayoutConstraint.activate([
      buttonsAndTitleStackView.topAnchor.constraint(
        equalTo: layoutGuide.topAnchor, constant: LayoutConstant.buttonsAndTitleStackViewTopPadding),
      buttonsAndTitleStackView.leadingAnchor.constraint(
        equalTo: layoutGuide.leadingAnchor, constant: LayoutConstant.leadingPadding),
      buttonsAndTitleStackView.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: LayoutConstant.trailingPadding),

      scrollViewFrameLayoutGuide.topAnchor.constraint(
        equalTo: buttonsAndTitleStackView.bottomAnchor,
        constant: LayoutConstant.scrollViewTopPadding),
      scrollViewFrameLayoutGuide.leadingAnchor.constraint(
        equalTo: buttonsAndTitleStackView.leadingAnchor),
      scrollViewFrameLayoutGuide.trailingAnchor.constraint(
        equalTo: buttonsAndTitleStackView.trailingAnchor),
      scrollViewFrameLayoutGuide.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor),

      selectedImageView.topAnchor.constraint(equalTo: scrollViewFrameLayoutGuide.topAnchor),
      selectedImageView.leadingAnchor.constraint(equalTo: scrollViewFrameLayoutGuide.leadingAnchor),
      selectedImageView.trailingAnchor.constraint(
        equalTo: scrollViewFrameLayoutGuide.trailingAnchor),
      selectedImageView.heightAnchor.constraint(equalToConstant: LayoutConstant.imageHeight),
      selectedImageView.widthAnchor.constraint(equalTo: scrollViewFrameLayoutGuide.widthAnchor),

      inputTextView.topAnchor.constraint(
        equalTo: selectedImageView.bottomAnchor, constant: LayoutConstant.textViewTopPadding),
      inputTextView.leadingAnchor.constraint(equalTo: scrollViewFrameLayoutGuide.leadingAnchor),
      inputTextView.trailingAnchor.constraint(equalTo: scrollViewFrameLayoutGuide.trailingAnchor),
      inputTextView.heightAnchor.constraint(equalToConstant: LayoutConstant.textViewHeight),

      helpButtonAndCountStackView.topAnchor.constraint(
        equalTo: inputTextView.bottomAnchor,
        constant: LayoutConstant.helpButtonAndCountStackViewTopPadding),
      helpButtonAndCountStackView.leadingAnchor.constraint(
        equalTo: scrollViewFrameLayoutGuide.leadingAnchor),
      helpButtonAndCountStackView.trailingAnchor.constraint(
        equalTo: scrollViewFrameLayoutGuide.trailingAnchor),
      helpButtonAndCountStackView.bottomAnchor.constraint(
        equalTo: scrollViewFrameLayoutGuide.bottomAnchor),
      helpButtonAndCountStackView.widthAnchor.constraint(
        equalTo: scrollViewFrameLayoutGuide.widthAnchor),
    ])
  }
}

#Preview {
  AltTextEditViewController(dataSource: NewPostEditDataSource())
}
