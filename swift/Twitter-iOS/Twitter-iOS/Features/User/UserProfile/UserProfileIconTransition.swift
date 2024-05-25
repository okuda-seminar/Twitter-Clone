import UIKit

class UserProfileIconTransition: NSObject, UIViewControllerAnimatedTransitioning {
  public var presenting = false
  // MARK: - UIViewControllerAnimatedTransitioning
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?)
    -> TimeInterval
  {
    return 0.7
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    if presenting {
      presentTransition(transitionContext: transitionContext)
    } else {
      dissmissalTransition(transitionContext: transitionContext)
    }
  }

  func presentTransition(transitionContext: UIViewControllerContextTransitioning) {
    let fromViewController =
      transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
      as! UserProfileViewController
    let toViewController =
      transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
      as! UserProfileIconDetailViewController
    let containerView = transitionContext.containerView
    let animationView = UIImageView(image: fromViewController.profileIcon)

    fromViewController.view.isHidden = true
    animationView.frame = containerView.convert(
      fromViewController.profileIconView.frame, from: fromViewController.view)

    toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
    toViewController.view.setNeedsLayout()
    toViewController.view.layoutIfNeeded()
    toViewController.view.alpha = 0
    toViewController.profileIconView.isHidden = true

    containerView.addSubview(toViewController.view)
    containerView.addSubview(animationView)

    UIView.animate(
      withDuration: transitionDuration(using: transitionContext),
      animations: {
        toViewController.view.alpha = 1.0
        animationView.frame = containerView.convert(
          toViewController.profileIconView.frame, from: toViewController.view)
      }
    ) { _ in
      fromViewController.view.isHidden = false
      toViewController.profileIconView.isHidden = false
      animationView.removeFromSuperview()
      transitionContext.completeTransition(true)
    }
  }

  func dissmissalTransition(transitionContext: UIViewControllerContextTransitioning) {
  }

}
