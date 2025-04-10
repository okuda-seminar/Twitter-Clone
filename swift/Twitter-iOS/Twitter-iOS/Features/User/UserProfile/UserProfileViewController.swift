import SwiftUI
import TwitterProfile
import UIKit

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/575
// - Reimplement User Profile UI Without Third Party Libraries.

/// The view controller managing the user profile view, including a user icon or posts.
class UserProfileViewController: UIViewController, TPDataSource, TPProgressDelegate {

  // MARK: - Public Props

  /// The model containing user information such as username or user icon.
  public var userModel: UserModel? {
    didSet {
      guard let userModel else { return }
      profileIconView.image = userModel.icon
    }
  }

  // This view is no longer used but is kept for compatibility
  // with the UserProfileIconTransition for now.
  // This should be addressed in the issue https://github.com/okuda-seminar/Twitter-Clone/issues/219.
  /// The image view displaying the user profile icon image.
  public let profileIconView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.isUserInteractionEnabled = true
    return imageView
  }()

  // MARK: - Private Props

  /// The view observer managing completions for specific user interactions.
  private var viewObserver = UserProfileViewObserver()

  // MARK: - TPDataSource Methods

  /// Returns the view controller managing the header part of the user profile view, including a banner or user icon.
  ///
  /// - Returns: The view controller managing the header part of the user profile view.
  func headerViewController() -> UIViewController {
    let headerVC = UserProfileHeaderViewController(viewObserver: viewObserver)
    return headerVC
  }

  /// Returns the view controller managing the bottom part of the user profile view, including a tab bar or posts.
  ///
  /// - Returns: The view controller managing the bottom part of the user profile view.
  func bottomViewController() -> any UIViewController & TwitterProfile.PagerAwareProtocol {
    let bottomVC = UserProfileTabsViewController()
    return bottomVC
  }

  /// Returns the minimum height value for the header view.
  ///
  /// - Returns: The minimum height value for the header view.
  func minHeaderHeight() -> CGFloat {
    return topInset + 36.0
  }

  // MARK: - TPProgressDelegate Methods

  /// Notifies the delegate when the scroll view is scrolled, providing the progress of the scroll.
  ///
  /// - Parameters:
  ///   - scrollView: The scroll view containing the header view controller and the bottom view controller.
  ///   - progress: The amount of scrolling progress for the header view.
  func tp_scrollView(_ scrollView: UIScrollView, didUpdate progress: CGFloat) {
  }

  /// Notifies the delegate when the scroll view is fully loaded.
  ///
  /// - Parameter scrollView: The scroll view containing the header view controller and the bottom view controller.
  func tp_scrollViewDidLoad(_ scrollView: UIScrollView) {
  }

  // MARK: - Private API

  /// Sets up completions for handling user interactions.
  private func setUpViewObserver() {
    viewObserver.didTapBackButtonCompletion = { [weak self] in
      self?.navigationController?.popViewController(animated: true)
    }
  }

  // MARK: - View Lifecycle

  /// Configures the user profile view with the data source and the delegate.
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tp_configure(with: self, delegate: self)
    setUpViewObserver()
    navigationController?.setNavigationBarHidden(true, animated: false)
  }

  // MARK: - Public API

  public init(userModel: UserModel? = nil) {
    self.userModel = userModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

#Preview {
  UserProfileViewController()
}
