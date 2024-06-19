import UIKit
import WebKit

class WebViewController: UIViewController {

  // MARK: - Public Properties

  public lazy var webView: WKWebView = {
    let config = WKWebViewConfiguration()
    let view = WKWebView(frame: .zero, configuration: config)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.scrollView.delegate = self
    view.uiDelegate = self
    view.navigationDelegate = self
    view.allowsBackForwardNavigationGestures = true
    return view
  }()

  // MARK: - Private Properties

  private enum LayoutConstant {
    static let headerViewHeight: CGFloat = 48.0
    static let headerEdgeHorizontalPadding: CGFloat = 12.0
  }

  private var url: URL?
  private var webViewLoadProgressObservation: NSKeyValueObservation?
  private var isDraggingWebView = false

  private lazy var headerView: WebViewHeaderView = {
    let view = WebViewHeaderView()
    view.translatesAutoresizingMaskIntoConstraints = false

    view.dismissalButton.addAction(
      .init { _ in
        self.dismiss(animated: true)
      }, for: .touchUpInside)

    view.reloadButton.addAction(
      .init { _ in
        self.webView.reload()
      }, for: .touchUpInside)

    return view
  }()

  private lazy var footerView: WebViewFooterView = {
    let view = WebViewFooterView()
    view.translatesAutoresizingMaskIntoConstraints = false

    view.navigationBackButton.addAction(
      .init { _ in
        if self.webView.canGoBack {
          self.webView.goBack()
        }
      }, for: .touchUpInside)

    view.navigationForwardButton.addAction(
      .init { _ in
        if self.webView.canGoForward {
          self.webView.goForward()
        }
      }, for: .touchUpInside)

    return view
  }()
  private var footerViewBottomConstraint: NSLayoutConstraint?

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
    setUpFunctionalities()
  }

  // MARK: - Private API

  private func setUpSubviews() {
    view.addSubview(headerView)
    view.addSubview(webView)
    view.addSubview(footerView)
    view.backgroundColor = .systemBackground

    guard let url else { return }
    webView.load(URLRequest(url: url))

    let layoutGuide = view.safeAreaLayoutGuide
    footerViewBottomConstraint = footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    guard let footerViewBottomConstraint else { return }
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      headerView.leadingAnchor.constraint(
        equalTo: view.leadingAnchor, constant: LayoutConstant.headerEdgeHorizontalPadding),
      headerView.trailingAnchor.constraint(
        equalTo: view.trailingAnchor, constant: -LayoutConstant.headerEdgeHorizontalPadding),
      headerView.heightAnchor.constraint(equalToConstant: LayoutConstant.headerViewHeight),

      webView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
      webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

      footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      footerViewBottomConstraint,
      footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }

  private func setUpFunctionalities() {
    webViewLoadProgressObservation = webView.observe(\.estimatedProgress, options: .new) {
      _, change in
      guard let progressInDouble = change.newValue else { return }
      self.headerView.progressView.setProgress(Float(progressInDouble), animated: true)

      if progressInDouble == 1.0 {
        self.headerView.didStopLoadingWebPage()
      } else {
        self.headerView.didStartLoadingWebPage()
      }
    }
  }
}

extension WebViewController: WKUIDelegate {}
extension WebViewController: WKNavigationDelegate {}

extension WebViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard !isDraggingWebView else { return }
    let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
    if translation.y < 0 {  // scrolling down
      let currentFooterHeight = footerView.frame.height
      footerViewBottomConstraint?.constant = currentFooterHeight
    } else {  // scrolling up
      footerViewBottomConstraint?.constant = 0
    }

    UIView.animate(withDuration: 0.3) {
      self.footerView.layoutIfNeeded()
    }
  }

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    isDraggingWebView = true
  }

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    isDraggingWebView = false
  }
}
