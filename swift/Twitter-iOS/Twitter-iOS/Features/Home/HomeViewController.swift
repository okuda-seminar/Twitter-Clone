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

  private lazy var newTweetEntryPointButtonController: NewTweetEntrypointButtonController = {
    let viewController = NewTweetEntrypointButtonController()
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(viewController)
    viewController.didMove(toParent: self)
    return viewController
  }()

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: HomeView())
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
    view.addSubview(newTweetEntryPointButtonController.view)

    addChild(newTweetEntryPointButtonController)
    newTweetEntryPointButtonController.didMove(toParent: self)

    let layoutGuide = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),

      newTweetEntryPointButtonController.view.bottomAnchor.constraint(
        equalTo: layoutGuide.bottomAnchor, constant: -LayoutConstant.edgePadding),
      newTweetEntryPointButtonController.view.trailingAnchor.constraint(
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

struct HomeView: View {
  @State private var activeTabModel: HomeTabModel.Tab = .forYou
  @State private var tabToScroll: HomeTabModel.Tab?
  private var tabModels: [HomeTabModel] = [
    .init(id: .forYou),
    .init(id: .following),
  ]

  var body: some View {
    VStack(spacing: 0) {
      TabBar()
      Tabs()
      Spacer()
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
          HomeTabView()
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

#Preview {
  HomeView()
}
