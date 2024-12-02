import UIKit

class SideMenuTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

  // MARK: - Public Props

  public var isPresenting: Bool = true

  public var dimmingViewTapAction: (() -> Void)? = nil

  // MARK: - Private Props

  private enum LayoutConstant {
    static let sideMenuWidth: CGFloat = 300.0
    static let dimmingViewAlphaWhenPresented: CGFloat = 0.5
    static let duration: TimeInterval = 0.25
  }

  private let dimmingView: UIView = {
    let view = UIView()
    view.backgroundColor = .black
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

    dimmingView.translatesAutoresizingMaskIntoConstraints = false
    toView.translatesAutoresizingMaskIntoConstraints = false

    containerView.addSubview(dimmingView)
    containerView.addSubview(toView)

    NSLayoutConstraint.activate([
      dimmingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      dimmingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor),
      dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

      toView.topAnchor.constraint(equalTo: containerView.topAnchor),
      toView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
      toView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      toView.widthAnchor.constraint(equalToConstant: LayoutConstant.sideMenuWidth),
    ])

    dimmingView.alpha = 0.0

    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapAction))
    dimmingView.addGestureRecognizer(tapGestureRecognizer)

    toView.frame.origin.x = -LayoutConstant.sideMenuWidth

    UIView.animate(
      withDuration: LayoutConstant.duration,
      animations: { [weak self] in
        toView.frame.origin.x = 0.0
        fromView.frame.origin.x = LayoutConstant.sideMenuWidth
        self?.dimmingView.alpha = LayoutConstant.dimmingViewAlphaWhenPresented
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
        self?.dimmingView.alpha = 0.0
      },
      completion: { finished in
        let completed = finished && !transitionContext.transitionWasCancelled
        transitionContext.completeTransition(completed)
      })
  }

  // MARK: - Tap Gesture Handling

  @objc
  private func onTapAction() {
    dimmingViewTapAction?()
  }
}
