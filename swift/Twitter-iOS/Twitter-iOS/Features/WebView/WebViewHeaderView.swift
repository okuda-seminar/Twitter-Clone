import UIKit

class WebViewHeaderView: UIView {

  public let dismissalButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    let titleWithUnderLine = NSAttributedString(
      string: LocalizedString.dismissalButtonText,
      attributes: [
        .underlineStyle: NSUnderlineStyle.single.rawValue, .underlineColor: UIColor.black,
      ])
    button.setAttributedTitle(titleWithUnderLine, for: .normal)
    button.sizeToFit()
    return button
  }()

  public let reloadButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "arrow.circlepath"), for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.tintColor = .black
    button.sizeToFit()
    return button
  }()

  public let progressView: UIProgressView = {
    let view = UIProgressView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private enum LayoutConstant {
    static let dismissalButtonHeight: CGFloat = 44.0
    static let progressViewHeight: CGFloat = 2.0
  }

  private enum LocalizedString {
    static let dismissalButtonText = String(localized: "Done")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpSubviews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Public API

  public func didStartLoadingWebPage() {
    self.progressView.isHidden = false
  }

  public func didStopLoadingWebPage() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.progressView.isHidden = true
      self.progressView.setProgress(0, animated: false)
    }
  }

  // MARK: - Private API

  private func setUpSubviews() {
    addSubview(dismissalButton)
    addSubview(reloadButton)
    addSubview(progressView)

    NSLayoutConstraint.activate([
      dismissalButton.leadingAnchor.constraint(equalTo: leadingAnchor),
      dismissalButton.heightAnchor.constraint(
        equalToConstant: LayoutConstant.dismissalButtonHeight),
      dismissalButton.bottomAnchor.constraint(equalTo: progressView.topAnchor),

      reloadButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      reloadButton.heightAnchor.constraint(
        equalToConstant: LayoutConstant.dismissalButtonHeight),
      reloadButton.bottomAnchor.constraint(equalTo: progressView.topAnchor),

      progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
      progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
      progressView.bottomAnchor.constraint(equalTo: bottomAnchor),
      progressView.heightAnchor.constraint(equalToConstant: LayoutConstant.progressViewHeight),
    ])
  }
}
