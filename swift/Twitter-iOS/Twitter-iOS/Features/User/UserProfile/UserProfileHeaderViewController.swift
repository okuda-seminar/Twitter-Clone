import SwiftUI
import UIKit

/// The view controller managing the header part of the user profile view.
class UserProfileHeaderViewController: UIViewController {

  // MARK: - Private Props

  /// The view observer managing completions for specific user interactions.
  private(set) var viewObserver: UserProfileViewObserver

  /// The hosting controller that embeds the SwiftUI header view.
  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(
      rootView: UserProfileHeaderView(viewObserver: viewObserver))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  // MARK: - Initializer

  init(viewObserver: UserProfileViewObserver) {
    self.viewObserver = viewObserver
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Private API

  /// Adds the hosting controller's view to the view hierarchy and configures layout constraints.
  private func setUpSubviews() {
    view.backgroundColor = .systemBackground
    view.addSubview(hostingController.view)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
    ])

    navigationController?.setNavigationBarHidden(true, animated: false)
  }

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }
}

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/219
// - Replace custom push transition with custom present one when tapping user icon.
extension UserProfileHeaderViewController: UINavigationControllerDelegate {

  /// Returns the custom animation for push navigation transitions.
  ///
  /// - Parameters:
  ///   - navigationController: The navigation controller managing the view controllers.
  ///   - operation: The type of transition operation.
  ///   - fromVC: The currently visible view controller.
  ///   - toVC: The view controller being navigated to.
  /// - Returns: The custom animation for navigation transitions.
  func navigationController(
    _ navigationController: UINavigationController,
    animationControllerFor operation: UINavigationController.Operation,
    from fromVC: UIViewController, to toVC: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    switch operation {
    case .push:
      let animator = UserProfileIconTransition()
      animator.presenting = true
      return animator
    case .pop:
      return nil
    default:
      return nil
    }
  }
}

// MARK: - View

/// The header view of the user profile view, managing the display of the banner and profile icon.
struct UserProfileHeaderView: View {

  /// The set of constant values used for layout configurations.
  private enum LayoutConstant {
    static let borderOffsetToSwitch: CGFloat = 80.0
  }

  /// The z-index values used for managing view layering.
  private enum ZIndex {
    static let bannerForeground: Double = 1.0
    static let profileIconBackground: Double = 0.0
    static let profileIconForeground: Double = 1.0
  }

  /// The current scale factor for the profile icon, adjusted based on scroll offset.
  private var currentProfileIconScale: CGFloat {
    let maxProfileIconScale: CGFloat = 1.0
    let maxScrollProgress: CGFloat = 1.0
    let progress = -scrollOffset / LayoutConstant.borderOffsetToSwitch
    let scale =
      1.8 - min(progress, maxScrollProgress)
    return min(scale, maxProfileIconScale)
  }

  /// The view observer managing completions for specific user interactions.
  @ObservedObject private(set) var viewObserver: UserProfileViewObserver

  /// The observable scroll offset used for managing parallax header functionality.
  @State private var scrollOffset: CGFloat = 0.0

  /// The observable title offset used for managing parallax header functionality.
  @State private var titleOffset: CGFloat = 0.0

  /// The main body of the header view.
  var body: some View {
    VStack(spacing: 0) {
      UserProfileBannerView(
        scrollOffset: $scrollOffset,
        titleOffset: $titleOffset,
        borderOffsetToSwitch: LayoutConstant.borderOffsetToSwitch,
        viewObserver: viewObserver
      )
      .frame(height: 140)
      .zIndex(ZIndex.bannerForeground)
      ProfileIcon()
        .zIndex(
          -scrollOffset > LayoutConstant.borderOffsetToSwitch
            ? ZIndex.profileIconBackground : ZIndex.profileIconForeground)
    }
  }

  /// The user's profile icon view with a dynamic scaling effect.
  ///
  /// - Returns: The user's profile icon view.
  @ViewBuilder
  private func ProfileIcon() -> some View {
    VStack {
      HStack {
        Image(systemName: "apple.logo")
          .resizable()
          .scaledToFit()
          .frame(width: 75, height: 75)
          .background(.white)
          .clipShape(Circle())
          .padding(.leading)
          .scaleEffect(currentProfileIconScale)

        Spacer()
      }
    }
  }
}

#Preview {
  UserProfileHeaderView(viewObserver: UserProfileViewObserver())
}
