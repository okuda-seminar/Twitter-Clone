import UIKit
import WebKit

class WebViewController: UIViewController {

  // Public properties

  public var url: URL?

  public lazy var webView: WKWebView = {
    let config = WKWebViewConfiguration()
    let view = WKWebView(frame: .zero, configuration: config)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.uiDelegate = self
    view.navigationDelegate = self
    return view
  }()

  // Private properties
  private enum LayoutConstant {
    static let headerEdgeHorizontalPadding: CGFloat = 12.0
    static let dismissalButtonHeight: CGFloat = 44.0
  }

  private enum LocalizedString {
    static let dismissalButtonText = String(localized: "Done")
  }

  private lazy var dismissalButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    let titleWithUnderLine = NSAttributedString(
      string: LocalizedString.dismissalButtonText,
      attributes: [
        .underlineStyle: NSUnderlineStyle.single.rawValue, .underlineColor: UIColor.black,
      ])
    button.setAttributedTitle(titleWithUnderLine, for: .normal)
    button.sizeToFit()
    button.addAction(
      .init { _ in
        self.dismiss(animated: true)
      }, for: .touchUpInside)
    return button
  }()

  public init(url: URL?) {
    self.url = url
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  // MARK: - Private API

  private func setUpSubviews() {
    view.addSubview(dismissalButton)
    view.addSubview(webView)
    view.backgroundColor = .systemBackground

    guard let url else { return }
    webView.load(URLRequest(url: url))

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      dismissalButton.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      dismissalButton.leadingAnchor.constraint(
        equalTo: view.leadingAnchor, constant: LayoutConstant.headerEdgeHorizontalPadding),
      dismissalButton.heightAnchor.constraint(
        equalToConstant: LayoutConstant.dismissalButtonHeight),

      webView.topAnchor.constraint(equalTo: dismissalButton.bottomAnchor),
      webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }
}

extension WebViewController: WKUIDelegate {}
extension WebViewController: WKNavigationDelegate {}
