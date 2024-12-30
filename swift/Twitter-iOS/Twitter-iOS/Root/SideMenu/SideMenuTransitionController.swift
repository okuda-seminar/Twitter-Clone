import UIKit

/// The controller that manages the custom transition animations for presenting and dismissing a side menu.
/// It also handles interactive gesture-based transitions using `UIPercentDrivenInteractiveTransition`.
class SideMenuTransitionController: NSObject {

  // MARK: - Private Props

  /// The animator responsible for implementing the side menu transition animation.
  private let animator = SideMenuTransitionAnimator()

  /// The percent-driven interactive transition object for managing pan-gesture-based transition animations.
  private var interactiveTransition: UIPercentDrivenInteractiveTransition? = nil

  /// The parent view controller of the main and side menu view controller, responsible for presenting and dismissing the side menu.
  private var parentViewController: UIViewController? = nil
  /// The view controller where the pan gesture is recognized to trigger the presenting side menu transition.
  private var mainViewController: UIViewController? = nil
  /// The view controller of the side menu view.
  private var sideMenuViewController: UIViewController? = nil

  /// The collection of gestures that can be canceled when the side menu is presented interactively.
  private var cancellableGestures: Set<UIGestureRecognizer> = []

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
    panGesture.delegate = self

    mainVC.view.addGestureRecognizer(panGesture)
  }

  public func presentSideMenu() {
    guard let parentViewController = parentViewController,
      let sideMenuViewController = sideMenuViewController
    else {
      return
    }
    let start = Date()
    parentViewController.present(sideMenuViewController, animated: true) {
      let end = Date()
      let elapsedTime = end.timeIntervalSince(start)
      print("sideMenu presentation time: ", elapsedTime)
      print("present method completed")
    }
  }

  public func dismissSideMenu() {
    guard let sideMenuViewController = sideMenuViewController else { return }
    let start = Date()
    sideMenuViewController.dismiss(animated: true) {
      let end = Date()
      let elapsedTime = end.timeIntervalSince(start)
      print("sideMenu dismissal time: ", elapsedTime)
      print("dismiss method completed")
    }
  }

  // MARK: - Gesture Handling

  /// Handles a pan gesture to manage the interactive side menu animation transition,
  /// updating, finishing, or canceling based on the gesture's horizontal translation or velocity.
  ///
  /// - Parameter gesture: The pan gesture recognizer managing the side menu animation transition.
  @objc
  private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
    switch gesture.state {
    case .began:
      interactiveTransition = UIPercentDrivenInteractiveTransition()
      interactiveTransition?.completionCurve = .linear
      cancellableGestures.forEach { $0.state = .cancelled }
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
      cancellableGestures.removeAll()
      interactiveTransition = nil
    case .cancelled:
      cancellableGestures.removeAll()
      cancelInteractiveTransition()
    case .failed:
      cancellableGestures.removeAll()
      cancelInteractiveTransition()
    default:
      break
    }
  }
}

extension SideMenuTransitionController: UIViewControllerTransitioningDelegate {

  // MARK: Delegate Methods

  /// Provides the animator responsible for managing the presentation of the side menu,
  /// and defines actions for user interactions on the dimming view and the container view.
  ///
  /// - Parameters:
  ///   - presented: The side menu view controller that is about to be presented onscreen.
  ///   - presenting: The view controller presenting the side menu.
  ///   - source: The view controller that initiated the presentation transition by calling `present(_:animated:completion:)`.
  /// - Returns: An animator configured with actions triggered by a tap gesture on the dimming view and a pan gesture on the container view.
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

  /// Provides the animator responsible for managing the dismissal transition of the side menu.
  ///
  /// - Parameter dismissed: The side menu view controller that is about to be dismissed.
  /// - Returns: The animator responsible for the dismissal transition.
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
    dismissSideMenu()
  }

  /// Determines whether the interactive transition should be completed or canceled
  /// based on the horizontal velocity of the gesture.
  ///
  /// - Parameter gesture: The pan gesture recognizer used to control the transition.
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

extension SideMenuTransitionController: UIGestureRecognizerDelegate {

  /// Determines whether the pan gesture recognizer should recognize the gesture simultaneously with another gesture recognizer,
  /// based on whether the other recognizer's view is a scroll view and its content offset.
  ///
  /// - Parameters:
  ///   - gestureRecognizer: The pan gesture recognizer used for triggering the side menu transition.
  ///   - otherGestureRecognizer: Another gesture recognizer that may conflict with the pan gesture recognizer.
  /// - Returns: A Boolean value indicating whether the gestures should be recognized simultaneously.
  func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
  ) -> Bool {
    guard let scrollView = otherGestureRecognizer.view as? UIScrollView else { return false }

    cancellableGestures.insert(otherGestureRecognizer)
    let isAtLeftEdge: Bool = scrollView.contentOffset.x <= 0
    return isAtLeftEdge
  }

  /// Determines whether the pan gesture recognizer should begin, based on the velocity of the gesture.
  ///
  /// - Parameter gestureRecognizer: The pan gesture recognizer used for triggering the side menu transition.
  /// - Returns: A Boolean value indicating whether the gesture should begin.
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    guard let panGesture = gestureRecognizer as? UIPanGestureRecognizer else { return false }

    let velocity = panGesture.velocity(in: panGesture.view)
    let isHorizontalPanToRight = velocity.x > 0 && velocity.x > abs(velocity.y)
    return isHorizontalPanToRight
  }
}
