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
    navigationItem.backButtonDisplayMode = .minimal
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

  private enum LayoutConstant {
    static let edgePadding = 16.0
  }

  private enum LocalizedString {
    static let headlineLabelText = String(localized: "Discover new Communities")
    static let seeLessOften = String(localized: "See less often")
    static let showMoreText = String(localized: "Show more")
  }

  private let communities: [CommunityModel] = {
    var communities: [CommunityModel] = []
    for _ in 0..<4 {
      communities.append(createFakeCommunityModel())
    }
    return communities
  }()

  var body: some View {
    VStack {
      HStack {
        Text(LocalizedString.headlineLabelText)
        Spacer()
        Menu {
          Button(
            action: {

            },
            label: {
              Label(LocalizedString.seeLessOften, systemImage: "face.dashed")
            })
        } label: {
          Image(systemName: "ellipsis")
        }
      }

      ForEach(communities) { community in
        CommunityCellView(community: community)
      }

      HStack {
        Button(
          action: {
            delegate?.didTapShowMoreButton()
          },
          label: {
            Text(LocalizedString.showMoreText)
          })
        Spacer()
      }

      Spacer()
    }
    .padding(.top, LayoutConstant.edgePadding)
    .padding(.leading, LayoutConstant.edgePadding)
    .padding(.trailing, LayoutConstant.edgePadding)
  }
}

protocol CommunitiesHomeViewDelegate: AnyObject {
  func didTapShowMoreButton()
}

#Preview {
  CommunitiesHomeView()
}
