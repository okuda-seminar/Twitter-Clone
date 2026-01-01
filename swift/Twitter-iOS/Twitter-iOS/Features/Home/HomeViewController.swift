import SafariServices
import SwiftUI
import UIKit
import os

import TwitterGraphql

/// The view controller responsible for displaying the home view of the app.
class HomeViewController: ViewControllerWithUserIconButton {

  /// The overlay view for the tab bar item that manages gesture recognizers.
  public lazy var tabBarItemOverlayView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    let longPressGestureRecognizer = UILongPressGestureRecognizer(
      target: self, action: #selector(didLongPressUITabBarItem))
    let tapGestureRecognizer = UITapGestureRecognizer(
      target: self, action: #selector(didTapUITabBarItem))
    view.addGestureRecognizer(longPressGestureRecognizer)
    view.addGestureRecognizer(tapGestureRecognizer)
    return view
  }()

  /// The set of constant values used for layout configurations.
  private enum LayoutConstant {
    static let edgePadding: CGFloat = 16.0
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/614
    // - Fetch Posts for 'For You' Tab in HomeViewController from Backend Server.
  }

  /// The set of localized strings.
  private enum LocalizedString {
    static let invalidURLErrorTitle = String(localized: "Invalid URL Error")
    static let invalidURLErrorMessage = String(
      localized: "The server URL is invalid. Please try again later or contact support.")
    static let invalidURLErrorCloseButtonTitle = String(localized: "OK")
    static let dataProcessingErrorTitle = String(localized: "Data Error")
    static let dataProcessingErrorMessage = String(
      localized:
        "The data from the server could not be processed. Please try again later or contact support."
    )
    static let dataProcessingErrorCloseButtonTitle = String(localized: "OK")
    static let unknownErrorTitle = String(localized: "Unknown Error")
    static let unknownErrorMessage = String(
      localized: "An unknown error occurred. Please try again later or contact support.")
    static let unknownErrorCloseButtonTitle = String(localized: "OK")
  }

  /// The flag indicating whether the bottom sheet should be opened.
  private var shouldOpenBottomSheet = false

  /// The flag whether this view has appeared.
  private var didAppear = false

  /// The service class to handle timeline-related operations.
  private lazy var timelineService = injectTimelineService()

  /// The data source that provides post models for the timeline.
  private let postsDataSource = TimelinePostsDataSource()

  /// The logger for storing error and debug messages.
  private let logger = Logger(subsystem: "Swift.Twitter-iOS", category: "HomeViewController")

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/595
  // - Implement Login Functionality to Remove Hardcoded Temporary ID.
  private let temporaryID: String = ProcessInfo.processInfo.environment["TEMPORARY_ID"] ?? ""

  /// The profile icon button of the current user.
  private lazy var profileIconButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(showSideMenu))
    button.tintColor = .black
    button.image = UIImage(systemName: "person.circle.fill")
    return button
  }()

  /// The button that navigates to the timeline settings view.
  private lazy var timelineSettingsEntryPointButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(presentTimelineSettings))
    button.tintColor = .black
    button.image = UIImage(systemName: "gear")
    return button
  }()

  /// The button that navigates to the new post edit view.
  private lazy var newPostEntryPointButtonController: NewPostEntrypointButtonController = {
    let viewController = NewPostEntrypointButtonController()
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(viewController)
    viewController.didMove(toParent: self)
    return viewController
  }()

  /// The hosting controller that embeds the SwiftUI home view.
  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(
      rootView: HomeView(delegate: self, postsDataSource: postsDataSource))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()

    NotificationCenter.default.addObserver(
      self, selector: #selector(refreshTimeline), name: .authServiceDidChangeAuthenticationState,
      object: nil)
  }

  /// Opens the bottom sheet if necessary and starts listening to the SSE connection after the view appears.
  ///
  /// - Parameter animated: The boolean value indicating whether the view will appear with the animation.
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    didAppear = true
    openBottomSheetIfNeeded()

    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/614
    // - Fetch Posts for 'For You' Tab in HomeViewController from Backend Server.
    // Replace this with operations that fetch real data from the backend server in the future.
    loadDataForForYouTab()
    refreshTimeline()
  }

  /// Stops listening to the SSE connection when the view disappears.
  ///
  /// - Parameter animated: The boolean value indicating whether the view disappears with the animation.
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    didAppear = false
  }

  // MARK: - Private API

  /// Sets up the subviews and their constraints.
  private func setUpSubviews() {
    view.backgroundColor = .systemBackground
    view.addSubview(hostingController.view)
    view.addSubview(newPostEntryPointButtonController.view)

    addChild(newPostEntryPointButtonController)
    newPostEntryPointButtonController.didMove(toParent: self)

    let layoutGuide = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),

      newPostEntryPointButtonController.view.bottomAnchor.constraint(
        equalTo: layoutGuide.bottomAnchor, constant: -LayoutConstant.edgePadding),
      newPostEntryPointButtonController.view.trailingAnchor.constraint(
        equalTo: layoutGuide.trailingAnchor, constant: -LayoutConstant.edgePadding),
    ])

    // set up the navigation header
    navigationController?.navigationBar.tintColor = .black
    navigationItem.leftBarButtonItems = [profileIconButton]
    navigationItem.rightBarButtonItems = [timelineSettingsEntryPointButton]
    navigationItem.titleView = UIImageView(image: UIImage(systemName: "apple.logo"))
  }

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/614
  // - Fetch Posts for 'For You' Tab in HomeViewController from Backend Server.
  /// Loads posts data for "For You" tab.
  private func loadDataForForYouTab() {
    postsDataSource.forYouTabPostModels = []
    for _ in 0..<30 {
      postsDataSource.forYouTabPostModels.append(createFakePostModel())
    }
  }

  // MARK: - Timeline

  @objc private func refreshTimeline() {
    timelineService.fetchTimelineData() { [weak self] timelineItems in
      self?.handleTimelineItems(timelineItems)
    }
  }

  /// Handles timeline events received from the SSE connection.
  ///
  /// - Parameters:
  ///   - eventType: The type of timeline SSE event.
  ///   - posts: The posts received from the event.
  private func handleTimelineItems(_ items: [TimelineQuery.Data.GetReverseChronologicalHomeTimeline]) {
    var posts: [PostModel] = []
    items.forEach { item in
      if let post = item.asPost,
         let postId = UUID(uuidString: post.id),
         let userIcon = UIImage(systemName: "person") {
        posts.append(PostModel(id: postId, bodyText: post.text, userIcon: userIcon, userName: "mock user name", isRepostedByCurrentUser: false))
      }
    }
    postsDataSource.followingTabPostModels = posts
  }

  /// Presents the alert pop up message with description.
  ///
  /// - Parameters:
  ///   - title: The title of the alert.
  ///   - message: The message of the alert.
  ///   - closeButtonTitle: The title of the close button of the alert.
  private func presentErrorAlert(title: String, message: String, closeButtonTitle: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: closeButtonTitle, style: .default))
    self.present(alertController, animated: true)
  }

  /// Presents the timeline settings view modally.
  @objc
  private func presentTimelineSettings() {
    let settingsHomeViewController = SettingsHomeViewController()
    let presentingViewController = UINavigationController(
      rootViewController: settingsHomeViewController)
    let backButtonImage = UIImage(systemName: "arrow.left")
    presentingViewController.navigationBar.backIndicatorImage = backButtonImage
    presentingViewController.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    presentingViewController.navigationBar.tintColor = .black

    settingsHomeViewController.navigationItem.backButtonDisplayMode = .minimal
    presentingViewController.pushViewController(
      TimelineSettingsViewController(), animated: false)
    presentingViewController.modalPresentationStyle = .fullScreen
    present(presentingViewController, animated: true)
  }

  // MARK: - UITabBarItem

  /// Handles a tap gesture on the home tab bar item.
  @objc
  private func didTapUITabBarItem() {
    NotificationCenter.default.post(name: .didTapHomeTabBarItem, object: nil)
  }

  /// Handles a long-press gesture on the home tab bar item.
  @objc
  private func didLongPressUITabBarItem() {
    shouldOpenBottomSheet = true
    guard !didAppear else {
      openBottomSheetIfNeeded()
      return
    }
    NotificationCenter.default.post(name: .didLongPressHomeTabBarItem, object: nil)
  }

  /// Opens the bottom sheet modally when the home tab bar item is long-pressed.
  private func openBottomSheetIfNeeded() {
    guard shouldOpenBottomSheet else { return }
    let viewControllerToPresent = HomeBottomSheetViewController()
    if let sheet = viewControllerToPresent.sheetPresentationController {
      sheet.detents = [.medium()]
    }
    present(viewControllerToPresent, animated: true)
    shouldOpenBottomSheet = false
  }
}

extension HomeViewController: HomeViewDelegate {

  /// Presents the post-sharing sheet modally.
  func showShareSheet() {
    let activityViewController = UIActivityViewController(
      activityItems: ["Deeplink"], applicationActivities: nil)
    self.present(activityViewController, animated: true)
  }

  /// Presents the reply editing sheet modally for editing a post reply.
  func showReplyEditSheet() {
    let replyEditViewController = ReplyEditViewController(originalPostModel: createFakePostModel())
    replyEditViewController.modalPresentationStyle = .fullScreen
    self.present(replyEditViewController, animated: true)
  }

  /// Presents the web page in a Safari view controller modally.
  ///
  /// - Parameter url: The url of the webpage to be presented.
  func openWebPage(url: URL?) {
    guard let url else { return }
    let webViewController = SFSafariViewController(url: url)
    webViewController.modalPresentationStyle = .fullScreen
    self.present(webViewController, animated: true)
  }
}

/// The SwiftUI view of the home view.
struct HomeView: View {
  public weak var delegate: HomeViewDelegate?

  @ObservedObject private(set) var postsDataSource: TimelinePostsDataSource

  @State private var activeTabModel: HomeTabModel.Tab = .forYou
  @State private var tabToScroll: HomeTabModel.Tab?

  @State private var showShareSheet = false
  @State private var reposting = false
  @State private var postToRepost: PostModel? = nil
  @State private var showReplyEditSheet = false
  @State private var urlStrToOpen = ""

  private var tabModels: [HomeTabModel] = [
    .init(id: .forYou),
    .init(id: .following),
  ]

  private enum LayoutConstant {
    static let homeViewVStackSpacing: CGFloat = 0.0
    static let tabsHStackSpacing: CGFloat = 0.0
    static let repostOptionsBottomSheetHeight: CGFloat = 200.0
  }

  // Need to define init to avoid a compile error.
  init(delegate: HomeViewDelegate? = nil, postsDataSource: TimelinePostsDataSource) {
    self.delegate = delegate
    self.postsDataSource = postsDataSource
  }

  var body: some View {
    VStack(spacing: LayoutConstant.homeViewVStackSpacing) {
      TabBar()
      Tabs()
      Spacer()
    }
    .onChange(of: showShareSheet) { _, newValue in
      if newValue {
        delegate?.showShareSheet()
        showShareSheet = false
      }
    }
    .onChange(of: showReplyEditSheet) { _, newValue in
      if newValue {
        delegate?.showReplyEditSheet()
        showReplyEditSheet = false
      }
    }
  }

  @ViewBuilder
  private func TabBar() -> some View {
    HStack {
      ForEach(tabModels) { tabModel in
        Spacer()
        Button(
          action: {
            withAnimation {
              activeTabModel = tabModel.id
              tabToScroll = tabModel.id
            }
          },
          label: {
            Text(tabModel.id.rawValue)
              .foregroundStyle(activeTabModel == tabModel.id ? Color.primary : .gray)
          }
        )
        .buttonStyle(.plain)
        Spacer()
      }
    }
    .padding(.vertical)
    .overlay(alignment: .bottom) {
      ZStack {
        Divider()
      }
    }
  }

  @ViewBuilder
  private func Tabs() -> some View {
    ScrollView(.horizontal) {
      LazyHStack(spacing: LayoutConstant.tabsHStackSpacing) {
        ForEach(tabModels) { tabModel in
          HomeTabView(
            showReplyEditSheet: $showReplyEditSheet,
            reposting: $reposting,
            postToRepost: $postToRepost,
            showShareSheet: $showShareSheet,
            urlStrToOpen: $urlStrToOpen,
            postModels: tabModel.id == .following
              ? $postsDataSource.followingTabPostModels : $postsDataSource.forYouTabPostModels
          )
          .frame(width: UIScreen.main.bounds.width)
        }
      }
      .scrollTargetLayout()
    }
    .scrollIndicators(.hidden)
    .scrollTargetBehavior(.paging)
    .scrollPosition(id: $tabToScroll)
    .onChange(of: tabToScroll) { _, newValue in
      if let newValue {
        withAnimation {
          tabToScroll = newValue
          activeTabModel = newValue
        }
      }
    }
    .onChange(of: urlStrToOpen) { _, newValue in
      if newValue.count > 0 {
        delegate?.openWebPage(url: URL(string: newValue))
        urlStrToOpen = ""
      }
    }
    .sheet(isPresented: $reposting) {
      RepostOptionsBottomSheet(postModel: $postToRepost)
        .presentationDetents([.height(LayoutConstant.repostOptionsBottomSheetHeight), .medium])
    }
  }
}

protocol HomeViewDelegate: AnyObject {
  func showShareSheet()
  func showReplyEditSheet()
  func openWebPage(url: URL?)
}

#Preview {
  HomeView(postsDataSource: createFakeTimelinePostsDataSource())
}
