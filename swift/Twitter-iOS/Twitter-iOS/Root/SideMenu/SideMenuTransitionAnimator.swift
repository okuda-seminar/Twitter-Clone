import UIKit

/// The animator that handles the presentation and dismissal transition animations of a side menu.
/// During presentation, the side menu slides in from the left edge and moves to the right.
/// During dismissal, the side menu slides out to the left.
class SideMenuTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

  // MARK: - Public Props

  /// The indicator whether the animator is presenting or dismissing the side menu.
  public var isPresenting: Bool = true

  /// The action that is called when the dimming view is tapped.
  public var dimmingViewTapAction: (() -> Void)? = nil
  /// The action that is called when the container view is panned with a gesture.
  public var containerViewPanAction: ((_ panGesture: UIPanGestureRecognizer) -> Void)? = nil

  // MARK: - Private Props

  private enum LayoutConstant {
    static let sideMenuWidth: CGFloat = 300.0
    static let duration: TimeInterval = 0.25
  }

  /// The view that dims the background when the side menu is presented.
  private let dimmingView: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    return view
  }()

  /// The gesture recognizer that handles pan gestures on the container view to initiate and manage the side menu transition.
  private let panGesture = UIPanGestureRecognizer()

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

  /// Implements the side menu's presentation animation, sliding it in from the left with a background dimming effect.
  /// - Parameter transitionContext: The context of the transition, containing the to/from views and other transition-related properties.
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

    panGesture.addTarget(self, action: #selector(onPanAction))
    containerView.addGestureRecognizer(panGesture)

    UIView.animate(
      withDuration: LayoutConstant.duration,
      animations: { [weak self] in
        toView.frame.origin.x = 0.0
        fromView.frame.origin.x = LayoutConstant.sideMenuWidth
        self?.dimmingView.alpha = 0.5
      },
      completion: { finished in
        let completed = finished && !transitionContext.transitionWasCancelled
        transitionContext.completeTransition(completed)
      })
  }

  /// Implements the side menu's dismissal animation, sliding it out to the left and fading out the background dimming view.
  /// - Parameter transitionContext: The context of the transition, containing the to/from views and other transition-related properties.
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

  // MARK: - Gesture Handling

  /// Handles tap gestures on the dimming view to trigger the dimming view tap action defined in `SideMenuTransitionController`.
  @objc
  private func onTapAction() {
    dimmingViewTapAction?()
  }

  /// Handles pan gestures on the container view to trigger the side menu pan action defined in `SideMenuTransitionController`.
  @objc
  private func onPanAction() {
    containerViewPanAction?(panGesture)
  }
}
