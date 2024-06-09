import SwiftUI
import UIKit

class UserConnectViewController: UIViewController {
  private static let navigationBarTitle = String(localized: "Connect")

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: UserConnectView())
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

    let layoutGuide = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
    ])

    // set up the navigation header
    navigationController?.navigationBar.tintColor = .black
    navigationItem.title = Self.navigationBarTitle
  }
}

struct UserConnectView: View {
  @State private var activeTab: CommunitiesConnectTabModel.Tab = .whoToFollow
  @State private var tabToScroll: CommunitiesConnectTabModel.Tab?

  private var tabs: [CommunitiesConnectTabModel] = [
    .init(id: .whoToFollow),
    .init(id: .creatorsForYou),
  ]

  var body: some View {
    VStack {
      TabBar()
      Tabs()
    }
  }

  @ViewBuilder
  private func TabBar() -> some View {
    HStack {
      ForEach(tabs) { tab in
        Spacer()
        Button(
          action: {
            withAnimation {
              activeTab = tab.id
              tabToScroll = tab.id
            }
          },
          label: {
            Text(tab.id.rawValue)
              .foregroundStyle(activeTab == tab.id ? Color.primary : .gray)
          }
        )
        .buttonStyle(.plain)
        .padding()

        Spacer()
      }
    }
    .overlay(alignment: .bottom) {
      ZStack {
        Divider()
      }
    }
  }

  @ViewBuilder
  private func Tabs() -> some View {
    GeometryReader { geoProxy in
      ScrollView(.horizontal) {
        LazyHStack(spacing: 0) {
          ForEach(tabs) { tab in
            UserConnectWhoToFollowView()
              .frame(width: geoProxy.size.width, alignment: .center)
          }
        }
        .scrollTargetLayout()
      }
      .scrollIndicators(.hidden)
      .scrollTargetBehavior(.paging)
      .scrollPosition(id: $tabToScroll)
      .onChange(of: tabToScroll) { _, newValue in
        guard let newValue else { return }
        withAnimation {
          tabToScroll = newValue
          activeTab = newValue
        }
      }
    }
  }
}

#Preview {
  UserConnectView()
}
