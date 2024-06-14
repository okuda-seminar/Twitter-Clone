import SwiftUI
import UIKit

class HomeViewController: ViewControllerWithUserIconButton {

  private enum LayoutConstant {
    static let homeTabSelectionHeight = 48.0
    static let edgePadding = 16.0
  }

  private lazy var profileIconButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(showSideMenu))
    button.tintColor = .black
    button.image = UIImage(systemName: "person.circle.fill")
    return button
  }()

  private lazy var timelineSettingsEntryPointButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(presentExploreSettings))
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

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

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
    navigationItem.backButtonDisplayMode = .minimal
    navigationItem.leftBarButtonItems = [profileIconButton]
    navigationItem.rightBarButtonItems = [timelineSettingsEntryPointButton]
    navigationItem.titleView = UIImageView(image: UIImage(systemName: "apple.logo"))
  }

  private func showTimelineSettings() {
    let timelineSettingsViewController = TimelineSettingsViewController()
    timelineSettingsViewController.modalPresentationStyle = .fullScreen
    present(timelineSettingsViewController, animated: true)
  }

  @objc
  private func presentExploreSettings() {
    let timelineSettingsViewController = TimelineSettingsViewController()
    timelineSettingsViewController.modalPresentationStyle = .fullScreen
    present(timelineSettingsViewController, animated: true)
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
}

struct HomeView: View {
  public weak var delegate: HomeViewDelegate?

  @State private var activeTabModel: HomeTabModel.Tab = .forYou
  @State private var tabToScroll: HomeTabModel.Tab?
  @State private var showShareSheet = false
  @State private var showReplyEditSheet = false
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
          HomeTabView(showReplyEditSheet: $showReplyEditSheet, showShareSheet: $showShareSheet)
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
  }
}

protocol HomeViewDelegate: AnyObject {
  func showShareSheet()
  func showReplyEditSheet()
}

#Preview {
  HomeView()
}
