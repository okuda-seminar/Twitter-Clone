import UIKit

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/509
// - Implement Tap Gesture on OverlayView to Dismiss Side Menu.

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/510
// - Implement Swipe and Pan Gesture to Enable Manual Side Menu Transition.

class SideMenuTransitionController: NSObject, UIViewControllerTransitioningDelegate {

  private let animator = SideMenuTransitionAnimator()

  func animationController(
    forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController
  ) -> (any UIViewControllerAnimatedTransitioning)? {
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
