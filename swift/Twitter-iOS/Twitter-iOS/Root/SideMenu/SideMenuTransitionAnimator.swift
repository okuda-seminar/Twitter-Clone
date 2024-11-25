import UIKit

class SideMenuTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

  // MARK: - Public Props

  public var isPresenting: Bool = true

  // MARK: - Private Props

  private enum LayoutConstant {
    static let sideMenuWidth: CGFloat = 300.0
    static let overlayViewAlphaWhenPresented: CGFloat = 0.5
    static let duration: TimeInterval = 0.25
  }

  private let overlayView: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    view.alpha = 0.0
    return view
  }()

  // MARK: - UIViewControllerAnimatedTransitioning

  func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?)
    -> TimeInterval
  {
    return LayoutConstant.duration
  }

  func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
    if isPresenting == true {
      presentSideMenuTransitionAnimation(using: transitionContext)
    } else {
      dismissalSideMenuTransitionAnimation(using: transitionContext)
    }
  }

  // MARK: - Transition Animations

  private func presentSideMenuTransitionAnimation(
    using transitionContext: any UIViewControllerContextTransitioning
  ) {
    guard let toView = transitionContext.viewController(forKey: .to)?.view,
      let fromView = transitionContext.viewController(forKey: .from)?.view
    else {
      transitionContext.completeTransition(false)
      return
    }

    let containerView = transitionContext.containerView

    overlayView.translatesAutoresizingMaskIntoConstraints = false
    toView.translatesAutoresizingMaskIntoConstraints = false

    containerView.addSubview(overlayView)
    containerView.addSubview(toView)

    NSLayoutConstraint.activate([
      overlayView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      overlayView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      overlayView.topAnchor.constraint(equalTo: containerView.topAnchor),
      overlayView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

      toView.topAnchor.constraint(equalTo: containerView.topAnchor),
      toView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
      toView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      toView.widthAnchor.constraint(equalToConstant: LayoutConstant.sideMenuWidth),
    ])

    toView.frame.origin.x = -LayoutConstant.sideMenuWidth

    UIView.animate(
      withDuration: LayoutConstant.duration,
      animations: { [weak self] in
        toView.frame.origin.x = 0.0
        fromView.frame.origin.x = LayoutConstant.sideMenuWidth
        self?.overlayView.alpha = LayoutConstant.overlayViewAlphaWhenPresented
      },
      completion: { finished in
        let completed = finished && !transitionContext.transitionWasCancelled
        transitionContext.completeTransition(completed)
      })
  }

  private func dismissalSideMenuTransitionAnimation(
    using transitionContext: any UIViewControllerContextTransitioning
  ) {
    guard let toView = transitionContext.viewController(forKey: .to)?.view,
      let fromView = transitionContext.viewController(forKey: .from)?.view
    else {
      transitionContext.completeTransition(false)
      return
    }

    UIView.animate(
      withDuration: LayoutConstant.duration,
      animations: { [weak self] in
        toView.frame.origin.x = 0.0
        fromView.frame.origin.x = -LayoutConstant.sideMenuWidth
        self?.overlayView.alpha = 0.0
      },
      completion: { finished in
        let completed = finished && !transitionContext.transitionWasCancelled
        transitionContext.completeTransition(completed)
      })
  }
}
