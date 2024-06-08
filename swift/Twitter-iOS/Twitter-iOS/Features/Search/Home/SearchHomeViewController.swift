import SwiftUI
import UIKit

class SearchHomeViewController: ViewControllerWithUserIconButton {

  private enum LayoutConstant {
    static let headerHeight = 48.0
    static let edgePadding = 16.0
  }

  private lazy var profileIconButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(showSideMenu))
    button.tintColor = .black
    button.image = UIImage(systemName: "person.circle.fill")
    return button
  }()

  private lazy var exploreSettingsEntryPointButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(presentExploreSettings))
    button.tintColor = .black
    button.image = UIImage(systemName: "gear")
    return button
  }()

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: SearchHomeView())
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  private let newTweetEntryPointButtonController = NewTweetEntrypointButtonController()

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
    title = ""
    navigationItem.leftBarButtonItems = [profileIconButton]
    navigationItem.rightBarButtonItems = [exploreSettingsEntryPointButton]
    let searchBar = TapOnlySearchBar()
    searchBar.delegate = self
    navigationItem.titleView = searchBar
  }

  // MARK: - Settings

  @objc
  private func presentExploreSettings() {
    let exploreSettingsViewController = ExploreSettingsViewController()
    exploreSettingsViewController.modalPresentationStyle = .fullScreen
    present(exploreSettingsViewController, animated: true)
  }
}

extension SearchHomeViewController: TapOnlySearchBarDelegate {
  func didTapSearchBar() {
    navigationItem.backButtonDisplayMode = .minimal
    navigationController?.pushViewController(SearchInputViewController(), animated: true)
  }
}

struct SearchHomeView: View {
  @State private var activeTab: SearchTabModel.Tab = .forYou
  @State private var tabBarToScroll: SearchTabModel.Tab?
  @State private var tabToScroll: SearchTabModel.Tab?

  private var tabs: [SearchTabModel] = [
    .init(id: .forYou),
    .init(id: .trending),
    .init(id: .news),
    .init(id: .sports),
    .init(id: .entertainment),
  ]
  var body: some View {
    VStack {
      TabBar()
      Tabs()
    }
  }

  @ViewBuilder
  private func TabBar() -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 40) {
        ForEach(tabs) { tab in
          Button(
            action: {
              withAnimation(.snappy) {
                activeTab = tab.id
                tabBarToScroll = tab.id
                tabToScroll = tab.id
              }
            },
            label: {
              Text(tab.id.rawValue)
                .foregroundStyle(activeTab == tab.id ? Color.primary : .gray)
            }
          )
          .buttonStyle(.plain)
        }
      }
      .scrollTargetLayout()
      .padding(.top)
      .padding(.bottom)
      .overlay(alignment: .bottom) {
        ZStack {
          Divider()
        }
      }
    }
    .scrollPosition(
      id: .init(
        get: {
          return tabBarToScroll
        }, set: { _ in }), anchor: .center
    )
    .safeAreaPadding(15)
  }

  @ViewBuilder
  private func Tabs() -> some View {
    GeometryReader { geoProxy in
      ScrollView(.horizontal) {
        LazyHStack {
          ForEach(tabs) { tab in
            switch tab.id {
            case .forYou:
              SearchTabView(showGIF: true)
                .frame(width: geoProxy.size.width)
            case .trending:
              SearchTabView()
                .frame(width: geoProxy.size.width)
            case .news:
              SearchTabView()
                .frame(width: geoProxy.size.width)
            case .sports:
              SearchTabView()
                .frame(width: geoProxy.size.width)
            case .entertainment:
              SearchTabView()
                .frame(width: geoProxy.size.width)
            }
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
            activeTab = newValue
            tabBarToScroll = newValue
            tabToScroll = newValue
          }
        }
      }
    }
  }
}

#Preview {
  SearchHomeView()
}
