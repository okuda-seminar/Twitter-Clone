import SwiftUI
import TwitterProfile
import UIKit
import XLPagerTabStrip

/// The view controller that manages tabs in the user profile view.
class UserProfileTabsViewController: ButtonBarPagerTabStripViewController, PagerAwareProtocol {

  // MARK: - Private Props

  /// The set of constant values used for layout configurations.
  private enum LayoutConstant {
    static let pagerTabHeight: CGFloat = 5.0
    static let selectedBarHeight: CGFloat = 0.5
  }

  /// The set of localized strings used for tab titles.
  private enum LocalizedString {
    static let postsTabTitle = String(localized: "Posts")
    static let repliesTabTitle = String(localized: "Replies")
    static let highlightsTabTitle = String(localized: "Highlights")
    static let mediaTabTitle = String(localized: "Media")
    static let likesTabTitle = String(localized: "Likes")
  }

  /// The enumeration of user profile tabs, each with an associated localized title.
  private enum UserProfileTab: Int, CaseIterable {
    case posts
    case replies
    case highlights
    case media
    case likes

    var title: String {
      switch self {
      case .posts: return LocalizedString.postsTabTitle
      case .replies: return LocalizedString.repliesTabTitle
      case .highlights: return LocalizedString.highlightsTabTitle
      case .media: return LocalizedString.mediaTabTitle
      case .likes: return LocalizedString.likesTabTitle
      }
    }
  }

  // MARK: - PagerAwareProtocol Props

  /// The delegate responsible for managing the content offset of the container view.
  public weak var pageDelegate: (any TwitterProfile.BottomPageDelegate)?

  /// The current view controller displayed in the user profile view.
  public var currentViewController: UIViewController? {
    viewControllers[currentIndex]
  }

  /// The height value for the tab bar.
  public var pagerTabHeight: CGFloat? {
    return LayoutConstant.pagerTabHeight
  }

  // MARK: - Initializer

  init() {
    super.init(nibName: nil, bundle: nil)
    configureTabBarSettings()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configureTabBarSettings()
  }

  // MARK: - Private API

  /// Configures the appearance of the tab bar, including its background color or selected bar height.
  private func configureTabBarSettings() {
    settings.style.buttonBarBackgroundColor = .systemBackground
    settings.style.buttonBarItemBackgroundColor = .systemBackground
    settings.style.selectedBarBackgroundColor = .gray
    settings.style.buttonBarItemTitleColor = .brandedLightBlue
    settings.style.selectedBarHeight = LayoutConstant.selectedBarHeight
  }

  /// Updates the text color of the tab button cells when the index changes.
  ///
  /// - Parameters:
  ///   - oldCell: The previous tab button cell that was selected.
  ///   - newCell: The new tab button cell that is selected.
  private func updateTabButtonColors(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?) {
    oldCell?.label.textColor = .gray
    newCell?.label.textColor = .brandedLightBlue
  }

  // MARK: - View Lifecycle

  /// Configures the delegate and updates the text color of tab button cells when the index changes.
  override func viewDidLoad() {
    super.viewDidLoad()

    delegate = self
    changeCurrentIndexProgressive = { [weak self] oldCell, newCell, _, _, _ in
      self?.updateTabButtonColors(oldCell: oldCell, newCell: newCell)
    }
  }

  // MARK: - ButtonBarPagerTabStripViewController Related Methods

  /// Provides the set of view controllers for tabs along with their index and title.
  ///
  /// - Parameter pagerTabStripController: The view controller that manages tab view controllers and paging functionality.
  /// - Returns: The set of view controllers for tabs.
  override func viewControllers(for pagerTabStripController: PagerTabStripViewController)
    -> [UIViewController]
  {
    var tabViewControllers: [UIViewController] = []

    for tab in UserProfileTab.allCases {
      let tabViewController = UserProfileTabViewController()
      tabViewController.pageIndex = tab.rawValue
      tabViewController.pageTitle = tab.title
      tabViewControllers.append(tabViewController)
    }

    return tabViewControllers
  }

  /// Updates the position of the selected tab when a tab change occurs, and notifies the page delegate.
  ///
  /// - Parameters:
  ///   - viewController: The view controller that controls each tab view.
  ///   - fromIndex: The index of the tab view that is being scrolled from.
  ///   - toIndex: The index of the tab view that is being scrolled to.
  ///   - progressPercentage: A value between 0.0 and 1.0 representing the scroll progress.
  ///   - indexWasChanged: A boolean value indicating whether the index was changed.
  override func updateIndicator(
    for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int,
    withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool
  ) {
    super.updateIndicator(
      for: viewController, fromIndex: fromIndex, toIndex: toIndex,
      withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
    guard indexWasChanged else { return }
    pageDelegate?.tp_pageViewController(self.currentViewController, didSelectPageAt: toIndex)
  }
}

#Preview {
  UserProfileTabsViewController()
}
