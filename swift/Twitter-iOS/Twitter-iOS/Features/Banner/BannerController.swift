import SwiftUI
import UIKit

class BannerController {

  public weak var parent: UIViewController?
  private let dataSource = BannerViewDataSource()

  private enum LayoutConstant {
    static let topPadding = 96.0
    static let bannerHeight = 128.0
    static let animationDuration = 0.3
  }

  private let hostingController: UIHostingController<BannerView>

  // MARK: - Initalization

  public init(message: String, bannerType: BannerView.BannerType = .TextAndButton) {
    hostingController = UIHostingController(
      rootView: BannerView(dataSource: dataSource, type: bannerType, headlineText: message))

    let defaultCenter = NotificationCenter.default
    defaultCenter.addObserver(
      self, selector: #selector(dismissPresentingBanner), name: .isBeingDismissedDidChange,
      object: nil)
  }

  public func show(on parent: UIViewController, duration: UInt64 = 5) {
    self.parent = parent
    parent.addChild(hostingController)
    hostingController.didMove(toParent: parent)
    parent.view.addSubview(hostingController.view)

    hostingController.view.frame = CGRect(
      x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: LayoutConstant.bannerHeight)

    UIView.animate(
      withDuration: LayoutConstant.animationDuration, delay: 0, options: .curveEaseIn,
      animations: {
        self.hostingController.view.frame = CGRect(
          x: 0, y: LayoutConstant.topPadding, width: UIScreen.main.bounds.size.width,
          height: LayoutConstant.bannerHeight)
      }
    ) { _ in
      Task { @MainActor [weak self] in
        try? await Task.sleep(nanoseconds: duration * NSEC_PER_SEC)
        self?.dismissPresentingBanner()
      }
    }
  }

  @objc
  public func dismissPresentingBanner() {
    UIView.animate(
      withDuration: LayoutConstant.animationDuration,
      animations: {
        self.hostingController.view.frame = CGRect(
          x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: LayoutConstant.bannerHeight)
      }
    ) { _ in
      self.hostingController.willMove(toParent: self.parent)
      self.hostingController.view.removeFromSuperview()
      self.hostingController.removeFromParent()
    }
  }
}
