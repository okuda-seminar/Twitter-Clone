import SwiftUI
import UIKit

class UserFollowRelationsViewController: UIViewController {

  // MARK: - Public properties

  public var userName: String = ""

  // MARK: - Private properties

  private lazy var connectEntryButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(showConnectPage))
    button.tintColor = .black
    button.image = UIImage(systemName: "person.badge.plus")
    return button
  }()

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: UserFollowRelationsView())
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  // MARK: - Private API

  private func setUpSubviews() {
    view.addSubview(hostingController.view)

    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])

    // Set up navigation
    navigationItem.title = userName
    let backButtonImage = UIImage(systemName: "left.arrow")
    navigationController?.navigationBar.backIndicatorImage = backButtonImage
    navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    navigationItem.rightBarButtonItem = connectEntryButton
  }

  @objc
  private func showConnectPage() {
    print("Tapped Connect")
  }
}

struct UserFollowRelationsView: View {
  @State private var tabs: [UserFollowRelationsTabModel] = [
    .init(id: .verifiedFollowers),
    .init(id: .followers),
    .init(id: .following),
  ]

  @State private var activeTab: UserFollowRelationsTabModel.Tab = .verifiedFollowers
  @State private var tabToScroll: UserFollowRelationsTabModel.Tab?

  var body: some View {
    VStack(spacing: 0) {
      Divider()
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
            withAnimation(.snappy) {
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
        Spacer()
      }
    }
    .padding(.top)
    .padding(.bottom)
    .overlay(alignment: .bottom) {
      ZStack(alignment: .leading) {
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
            Text("dummy tab")
              .frame(width: geoProxy.size.width, height: geoProxy.size.height, alignment: .center)
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
            activeTab = newValue
          }
        }
      }
    }
  }
}

#Preview {
  UserFollowRelationsView()
}
