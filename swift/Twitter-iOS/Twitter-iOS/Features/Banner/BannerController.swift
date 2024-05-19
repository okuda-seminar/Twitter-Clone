import SwiftUI
import UIKit

class BannerController {

  public weak var parent: UIViewController?
  private let dataSource = BannerViewDataSource()

  private enum LayoutConstant {
    static let topPadding = 240.0
  }

  private let hostingController: UIHostingController<BannerView>

  // MARK: - Initalization

  public init(message: String) {
    hostingController = UIHostingController(
      rootView: BannerView(dataSource: dataSource, headlineText: message))
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false

    let defaultCenter = NotificationCenter.default
    defaultCenter.addObserver(
      self, selector: #selector(dismissPresentingBanner), name: .isBeingDismissedDidChange,
      object: nil)
  }

  public func show(on parent: UIViewController, duration: CGFloat = 5.0) {
    self.parent = parent
    parent.addChild(hostingController)
    hostingController.didMove(toParent: parent)
    parent.view.addSubview(hostingController.view)

    let layoutGuide = parent.view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
    ])

    UIView.animate(
      withDuration: 0.3, delay: 0, options: .curveEaseIn,
      animations: {
        self.hostingController.view.frame.origin.y = LayoutConstant.topPadding
      }
    ) { _ in
      DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
        self.dismissPresentingBanner()
      }
    }
  }

  @objc
  public func dismissPresentingBanner() {
    UIView.animate(
      withDuration: 0.3,
      animations: {
        self.hostingController.view.frame.origin.y = -self.hostingController.view.frame.height
      }
    ) { _ in
      self.hostingController.willMove(toParent: self.parent)
      self.hostingController.view.removeFromSuperview()
      self.hostingController.removeFromParent()
    }
  }
}
