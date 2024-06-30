import SwiftUI
import UIKit

class CommunitiesHomeViewController: ViewControllerWithUserIconButton {
  private enum LocalizedString {
    static let title = String(localized: "Communities")
  }

  private var communities = ["sample", "community", "with", "collection view"]

  private lazy var profileIconButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(showSideMenu))
    button.tintColor = .black
    button.image = UIImage(systemName: "person.circle.fill")
    return button
  }()

  private lazy var searchButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(pushCommunitiesSearchViewController)
    )
    button.image = UIImage(systemName: "magnifyingglass")
    button.tintColor = .black
    return button
  }()

  private lazy var newCommunityCreationEntryPointButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "", style: .plain, target: self, action: #selector(showNewCommunityCreationSheet))
    button.image = UIImage(systemName: "person.2")
    return button
  }()

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: CommunitiesHomeView(delegate: self))
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
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
    ])

    // set up the navigation header
    navigationController?.navigationBar.tintColor = .black
    navigationItem.title = LocalizedString.title
    navigationItem.leftBarButtonItems = [profileIconButton]
    navigationItem.rightBarButtonItems = [newCommunityCreationEntryPointButton, searchButton]
  }

  @objc
  private func showNewCommunityCreationSheet() {
    // We only show the sheet for non premium users.
    let blockedNewCommunityCreationBottomSheetViewController =
      BlockedNewCommunityCreationBottomSheetViewController()

    if let sheet = blockedNewCommunityCreationBottomSheetViewController.sheetPresentationController
    {
      sheet.detents = [.medium()]
      sheet.prefersGrabberVisible = true
    }
    present(blockedNewCommunityCreationBottomSheetViewController, animated: true, completion: nil)
  }

  @objc
  private func pushCommunitiesSearchViewController() {
    navigationController?.pushViewController(CommunitiesSearchViewController(), animated: true)
  }
}

extension CommunitiesHomeViewController: CommunitiesHomeViewDelegate {
  func didTapShowMoreButton() {
    pushCommunitiesSearchViewController()
  }
}

struct CommunitiesHomeView: View {
  public weak var delegate: CommunitiesHomeViewDelegate?

  @State private var activeTabModel: CommunityHomeTabModel.Tab = .myCommunity
  @State private var tabToScroll: CommunityHomeTabModel.Tab?
  @State private var showMoreCommunities = false

  private enum LocalizedString {
    static let seeLessOften = String(localized: "See less often")
  }

  private let tabModels: [CommunityHomeTabModel] = [
    .init(id: .myCommunity),
    .init(id: .explore),
  ]

  var body: some View {
    VStack {
      TabBar()
      Tabs()
      Spacer()
    }
    .onChange(of: showMoreCommunities) { _, newValue in
      if newValue {
        delegate?.didTapShowMoreButton()
        showMoreCommunities = false
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
          switch tabModel.id {
          case .myCommunity:
            CommunitiesHomeMyCommunitiesTabView(showMoreCommunities: $showMoreCommunities)
              .frame(width: UIScreen.main.bounds.width)
          case .explore:
            CommunitiesHomeExploreTabView()
              .frame(width: UIScreen.main.bounds.width)
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
          tabToScroll = newValue
          activeTabModel = newValue
        }
      }
    }
  }
}

protocol CommunitiesHomeViewDelegate: AnyObject {
  func didTapShowMoreButton()
}

#Preview {
  CommunitiesHomeView()
}
