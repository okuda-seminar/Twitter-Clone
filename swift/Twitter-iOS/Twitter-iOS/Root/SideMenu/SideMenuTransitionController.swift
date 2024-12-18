import SwiftUI
import UIKit

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/531
// - Enable Side Menu Access via Gesture Interaction Within ScrollView.

class SideMenuTransitionController: NSObject {

  // MARK: - Private Props

  private let animator = SideMenuTransitionAnimator()

  private var interactiveTransition: UIPercentDrivenInteractiveTransition? = nil

  private var parentViewController: UIViewController? = nil
  private var mainViewController: UIViewController? = nil
  private var sideMenuViewController: UIViewController? = nil

  // MARK: - Public API

  /// Sets up the view controllers involved in the side menu transition, configuring the presentation style and adding a pan gesture recognizer.
  ///
  /// - Parameters:
  ///   - parentVC: The parent view controller of the main and side menu view controller, responsible for presenting and dismissing the side menu.
  ///   - mainVC: The view controller where the pan gesture is recognized to trigger the presenting side menu transition.
  ///   - sideMenuVC: The view controller of the side menu view.
  public func setUpViewControllersForSideMenuTransition(
    parentVC: UIViewController, mainVC: UIViewController, sideMenuVC: UIViewController
  ) {
    self.parentViewController = parentVC
    self.mainViewController = mainVC
    self.sideMenuViewController = sideMenuVC

    guard let sideMenuViewController = sideMenuViewController else { return }
    sideMenuViewController.modalPresentationStyle = .custom
    sideMenuViewController.transitioningDelegate = self

    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
    mainVC.view.addGestureRecognizer(panGesture)
  }

  public func presentSideMenu() {
    guard let parentViewController = parentViewController,
      let sideMenuViewController = sideMenuViewController
    else {
      return
    }
    parentViewController.present(sideMenuViewController, animated: true)
  }

  public func dismissSideMenu() {
    guard let sideMenuViewController = sideMenuViewController else { return }
    sideMenuViewController.dismiss(animated: true)
  }

  // MARK: - Gesture Handling

  @objc
  private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
    switch gesture.state {
    case .began:
      interactiveTransition = UIPercentDrivenInteractiveTransition()
      interactiveTransition?.completionCurve = .linear
      presentSideMenu()
    case .changed:
      guard let gestureView = gesture.view else { return }
      let horizontalTranslation = gesture.translation(in: gestureView).x
      let percentComplete = max(horizontalTranslation / gestureView.bounds.width, 0)
      interactiveTransition?.update(percentComplete)
    case .ended:
      if let gestureView = gesture.view, gesture.velocity(in: gestureView).x > 0 {
        interactiveTransition?.finish()
      } else {
        interactiveTransition?.cancel()
      }
      interactiveTransition = nil
    case .cancelled:
      cancelInteractiveTransition()
    case .failed:
      cancelInteractiveTransition()
    default:
      break
    }
  }
}

extension SideMenuTransitionController: UIViewControllerTransitioningDelegate {

  // MARK: Delegate Methods

  func animationController(
    forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController
  ) -> (any UIViewControllerAnimatedTransitioning)? {
    animator.dimmingViewTapAction = { [weak presented] in presented?.dismiss(animated: true) }
    animator.containerViewPanAction = { [weak self, weak presented] gesture in
      switch gesture.state {
      case .began:
        self?.setUpInteractiveTransitionForDismissal(forPresented: presented)
      case .changed:
        guard let gestureView = gesture.view else { return }
        let horizontalTranslation = gesture.translation(in: gestureView).x
        let percentComplete = -min(horizontalTranslation / gestureView.bounds.width, 0)
        self?.interactiveTransition?.update(percentComplete)
      case .ended:
        self?.completeInteractiveTransitionForDismissal(withGesture: gesture)
      case .cancelled:
        self?.cancelInteractiveTransition()
      case .failed:
        self?.cancelInteractiveTransition()
      default:
        break
      }
    }

    animator.isPresenting = true
    return animator
  }

  func animationController(forDismissed dismissed: UIViewController) -> (
    any UIViewControllerAnimatedTransitioning
  )? {
    animator.isPresenting = false
    return animator
  }

  func interactionControllerForPresentation(
    using animator: any UIViewControllerAnimatedTransitioning
  ) -> (any UIViewControllerInteractiveTransitioning)? {
    if animator is SideMenuTransitionAnimator {
      return interactiveTransition
    } else {
      return nil
    }
  }

  func interactionControllerForDismissal(using animator: any UIViewControllerAnimatedTransitioning)
    -> (any UIViewControllerInteractiveTransitioning)?
  {
    if animator is SideMenuTransitionAnimator {
      return interactiveTransition
    } else {
      return nil
    }
  }

  // MARK: - Private API

  private func setUpInteractiveTransitionForDismissal(forPresented presented: UIViewController?) {
    interactiveTransition = UIPercentDrivenInteractiveTransition()
    interactiveTransition?.completionCurve = .linear
    presented?.dismiss(animated: true)
  }

  private func completeInteractiveTransitionForDismissal(
    withGesture gesture: UIPanGestureRecognizer
  ) {
    if let gestureView = gesture.view, gesture.velocity(in: gestureView).x < 0 {
      interactiveTransition?.finish()
    } else {
      interactiveTransition?.cancel()
    }
    interactiveTransition = nil
  }

  private func cancelInteractiveTransition() {
    interactiveTransition?.cancel()
    interactiveTransition = nil
  }
}
