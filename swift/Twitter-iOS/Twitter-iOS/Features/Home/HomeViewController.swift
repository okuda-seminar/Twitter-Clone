import SafariServices
import SwiftUI
import UIKit

class HomeViewController: ViewControllerWithUserIconButton {

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

  private enum LayoutConstant {
    static let homeTabSelectionHeight = 48.0
    static let edgePadding = 16.0
  }

  private var shouldOpenBottomSheet = false
  private var didAppear = false

  private lazy var profileIconButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(showSideMenu))
    button.tintColor = .black
    button.image = UIImage(systemName: "person.circle.fill")
    return button
  }()

  private lazy var timelineSettingsEntryPointButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(presentTimelineSettings))
    button.tintColor = .black
    button.image = UIImage(systemName: "gear")
    return button
  }()

  private lazy var newPostEntryPointButtonController: NewPostEntrypointButtonController = {
    let viewController = NewPostEntrypointButtonController()
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(viewController)
    viewController.didMove(toParent: self)
    return viewController
  }()

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: HomeView(delegate: self))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    didAppear = true
    openBottomSheetIfNeeded()
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    didAppear = false
  }

  // MARK: - Private API

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

  @objc
  private func didTapUITabBarItem() {
    NotificationCenter.default.post(name: .didTapHomeTabBarItem, object: nil)
  }

  @objc
  private func didLongPressUITabBarItem() {
    shouldOpenBottomSheet = true
    guard !didAppear else {
      openBottomSheetIfNeeded()
      return
    }
    NotificationCenter.default.post(name: .didLongPressHomeTabBarItem, object: nil)
  }

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
  func showShareSheet() {
    let activityViewController = UIActivityViewController(
      activityItems: ["Deeplink"], applicationActivities: nil)
    self.present(activityViewController, animated: true)
  }

  func showReplyEditSheet() {
    let replyEditViewController = ReplyEditViewController(originalPostModel: createFakePostModel())
    replyEditViewController.modalPresentationStyle = .fullScreen
    self.present(replyEditViewController, animated: true)
  }

  func openWebPage(url: URL?) {
    guard let url else { return }
    let webViewController = SFSafariViewController(url: url)
    webViewController.modalPresentationStyle = .fullScreen
    self.present(webViewController, animated: true)
  }
}

struct HomeView: View {
  public weak var delegate: HomeViewDelegate?

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

  // Need to define init to avoid a compile error.
  init(delegate: HomeViewDelegate? = nil) {
    self.delegate = delegate
  }

  var body: some View {
    VStack(spacing: 0) {
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
    .padding(.top)
    .padding(.bottom)
    .overlay(alignment: .bottom) {
      ZStack {
        Divider()
      }
    }
  }

  @ViewBuilder
  private func Tabs() -> some View {
    ScrollView(.horizontal) {
      LazyHStack(spacing: 0) {
        ForEach(tabModels) { tabModel in
          HomeTabView(
            showReplyEditSheet: $showReplyEditSheet,
            reposting: $reposting,
            postToRepost: $postToRepost,
            showShareSheet: $showShareSheet,
            urlStrToOpen: $urlStrToOpen
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
        .presentationDetents([.height(200), .medium])
    }
  }
}

protocol HomeViewDelegate: AnyObject {
  func showShareSheet()
  func showReplyEditSheet()
  func openWebPage(url: URL?)
}

#Preview {
  HomeView()
}
