import UIKit

public final class WebViewFooterView: UIView {

  // MARK: - Public Properties

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/301
  // - Enable navigation back / forward buttons only when back / forward are avilable in WebView.
  public let navigationBackButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.tintColor = .black
    return button
  }()

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/301
  // - Enable navigation back / forward buttons only when back / forward are avilable in WebView.
  public let navigationForwardButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.tintColor = .black
    return button
  }()

  public let shareButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.tintColor = .black
    return button
  }()

  public let safariButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "safari"), for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.tintColor = .black
    return button
  }()

  // MARK: - Private Properties

  private enum LayoutConstant {
    static let topEdgePadding: CGFloat = 8.0
    static let horizontalEdgePadding: CGFloat = 36.0
    static let contentHeight: CGFloat = 44.0
    static let bottomEdgePadding: CGFloat = 18.0
  }

  // MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private API

  private func setUpSubviews() {
    let horizontalStackView = UIStackView(arrangedSubviews: [
      navigationBackButton, navigationForwardButton, shareButton, safariButton,
    ])
    horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
    horizontalStackView.axis = .horizontal
    horizontalStackView.distribution = .equalSpacing

    backgroundColor = .brandedWhiteBackGround
    addSubview(horizontalStackView)
    NSLayoutConstraint.activate([
      horizontalStackView.topAnchor.constraint(
        equalTo: topAnchor, constant: LayoutConstant.topEdgePadding),
      horizontalStackView.leadingAnchor.constraint(
        equalTo: leadingAnchor, constant: LayoutConstant.horizontalEdgePadding),
      horizontalStackView.trailingAnchor.constraint(
        equalTo: trailingAnchor, constant: -LayoutConstant.horizontalEdgePadding),
      horizontalStackView.heightAnchor.constraint(equalToConstant: LayoutConstant.contentHeight),
      horizontalStackView.bottomAnchor.constraint(
        equalTo: bottomAnchor, constant: -LayoutConstant.bottomEdgePadding),
    ])
  }
}
