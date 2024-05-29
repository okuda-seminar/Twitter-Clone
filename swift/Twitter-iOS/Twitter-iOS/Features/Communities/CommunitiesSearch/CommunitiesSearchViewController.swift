import SwiftUI
import UIKit

class CommunitiesSearchViewController: UIViewController {
  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: CommunitiesSearchView())
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

    // set up navigation bar
    let backButtonImage = UIImage(systemName: "arrow.left")
    navigationController?.navigationBar.backIndicatorImage = backButtonImage
    navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
  }
}

struct CommunitiesSearchView: View {
  private var filteredCommunityModels: [CommunityModel] {
    var communities: [CommunityModel] = []
    for _ in 0..<20 {
      communities.append(createFakeCommunityModel())
    }
    return communities
  }

  private var communityFilterModels: [CommunityFilterModel] {
    var communityFilters: [CommunityFilterModel] = []
    for _ in 0..<10 {
      communityFilters.append(createFakeCommunityFilterModel())
    }
    return communityFilters
  }

  var body: some View {
    ScrollView(.vertical) {
      VStack {
        TabBar()
        Tab()
      }
    }
  }

  @ViewBuilder
  private func TabBar() -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(communityFilterModels) { communityFilter in
          Button(
            action: {
            },
            label: {
              Text(communityFilter.name)
                .underline()
            }
          )
          .foregroundStyle(.primary)
          .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
          .overlay(
            RoundedRectangle(cornerRadius: 24)
              .stroke(Color(uiColor: .lightGray), lineWidth: 1.0)
          )
        }
      }
    }
  }

  @ViewBuilder
  private func Tab() -> some View {
    LazyVStack {
      ForEach(filteredCommunityModels) { community in
        CommunityCellView(community: community)
      }
    }
  }
}

#Preview {
  CommunitiesSearchView()
}
