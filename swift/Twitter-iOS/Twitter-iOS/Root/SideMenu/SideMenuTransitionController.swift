import UIKit

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/510
// - Implement Swipe and Pan Gesture to Enable Manual Side Menu Transition.

class SideMenuTransitionController: NSObject, UIViewControllerTransitioningDelegate {

  private let animator = SideMenuTransitionAnimator()

  func animationController(
    forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController
  ) -> (any UIViewControllerAnimatedTransitioning)? {
    animator.dimmingViewTapAction = { [weak presented] in presented?.dismiss(animated: true) }
    animator.isPresenting = true
    return animator
  }

  func animationController(forDismissed dismissed: UIViewController) -> (
    any UIViewControllerAnimatedTransitioning
  )? {
    animator.isPresenting = false
    return animator
  }
}
