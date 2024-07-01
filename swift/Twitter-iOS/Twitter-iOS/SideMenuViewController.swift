import SwiftUI
import UIKit

class SideMenuViewController: UIViewController {

  public var currentUser: CurrentUser
  public weak var sideMenuViewDelegate: SideMenuViewDelegate?

  // MARK: - Public API

  public init(currentUser: CurrentUser, sideMenuViewDelegate: SideMenuViewDelegate? = nil) {
    self.currentUser = currentUser
    self.sideMenuViewDelegate = sideMenuViewDelegate
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  // MARK: - Private API

  private func setUpSubviews() {
    let hostingController = UIHostingController(
      rootView: SideMenuView(
        userName: currentUser.userName, numOfFollowing: currentUser.numOfFollowing,
        numOfFollowers: currentUser.numOfFollowers, delegate: sideMenuViewDelegate))
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(hostingController)
    hostingController.didMove(toParent: self)
    view.addSubview(hostingController.view)

    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
}

struct SideMenuView: View {
  public var userName: String
  public var numOfFollowing: Int
  public var numOfFollowers: Int
  public weak var delegate: SideMenuViewDelegate?

  private enum LayoutConstant {
    static let imageSize: CGFloat = 20.0
    static let disclosureViewWidth: CGFloat = 300.0
  }

  private enum LocalizedString {
    static let following = String(localized: "Following")
    static let followers = String(localized: "Followers")
    static let profile = String(localized: "Profile")
    static let bookmarks = String(localized: "Bookmarks")
    static let jobs = String(localized: "Jobs")
    static let lists = String(localized: "Lists")
    static let spaces = String(localized: "Spaces")
    static let followerRequests = String(localized: "Follower Requests")
    static let monetization = String(localized: "Monetization")

    static let settingsAndSupport = String(localized: "Settings and Support")
    static let settingsAndPrivacy = String(localized: "Settings and privacy")
    static let helpCenter = String(localized: "Help Center")
    static let purchases = String(localized: "Purchases")
  }

  @State private var isSettingsAndSupportMenuExpanded = false

  var body: some View {
    VStack(alignment: .leading) {
      Header()

      Divider()
        .padding(.bottom)

      MainMenu()

      Divider()
        .padding(.top)

      SettingsAndSupportMenu()

      Spacer()
    }
    .padding()
  }

  @ViewBuilder
  private func Header() -> some View {
    Button(
      action: {
        delegate?.didTapUserProfile()
      },
      label: {
        Image(systemName: "person.circle.fill")
          .resizable()
          .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
          .foregroundStyle(.black)
      })

    Button(
      action: {
        delegate?.didTapUserProfile()
      },
      label: {
        Text(userName)
      }
    )
    .foregroundStyle(.primary)

    HStack {
      Button(
        action: {
          delegate?.didTapUserFollowRelationsButton(userName: userName)
        },
        label: {
          Text("\(numOfFollowing) \(LocalizedString.following)")
            .foregroundStyle(.black)
        })

      Button(
        action: {
          delegate?.didTapUserFollowRelationsButton(userName: userName)
        },
        label: {
          Text("\(numOfFollowers) \(LocalizedString.followers)")
            .foregroundStyle(.black)
        })
    }
  }

  @ViewBuilder
  private func MainMenu() -> some View {
    Button(
      action: {
        delegate?.didTapUserProfile()
      },
      label: {
        Image(systemName: "person")
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
        Text(LocalizedString.profile)
      }
    )
    .buttonStyle(.plain)

    Button(
      action: {
        delegate?.didTapBookmarks()
      },
      label: {
        Image(systemName: "bookmark")
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
        Text(LocalizedString.bookmarks)
      }
    )
    .buttonStyle(.plain)

    Button(
      action: {
        delegate?.didTapJobs()
      },
      label: {
        Image(systemName: "handbag")
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
        Text(LocalizedString.jobs)
      }
    )
    .buttonStyle(.plain)

    Button(
      action: {
      },
      label: {
        Image(systemName: "list.clipboard")
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
        Text(LocalizedString.lists)
      }
    )
    .buttonStyle(.plain)

    Button(
      action: {
      },
      label: {
        Image(systemName: "mic")
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
        Text(LocalizedString.spaces)
      }
    )
    .buttonStyle(.plain)

    Button(
      action: {
        delegate?.didTapFollowerRequests()
      },
      label: {
        Image(systemName: "person.badge.plus")
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
        Text(LocalizedString.followerRequests)
      }
    )
    .buttonStyle(.plain)

    Button(
      action: {
        delegate?.didTapFollowerRequests()
      },
      label: {
        Image(systemName: "bitcoinsign.circle")
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
        Text(LocalizedString.monetization)
      }
    )
    .buttonStyle(.plain)
  }

  @ViewBuilder
  private func SettingsAndSupportMenu() -> some View {
    DisclosureGroup(
      LocalizedString.settingsAndSupport, isExpanded: $isSettingsAndSupportMenuExpanded
    ) {
      HStack {
        Image(systemName: "gear")
        Text(LocalizedString.settingsAndPrivacy)
        Spacer()
      }
      .padding()
      .onTapGesture {
        delegate?.didTapSettingsAndPrivacy()
      }

      HStack {
        Image(systemName: "questionmark.circle")
        Text(LocalizedString.helpCenter)
        Spacer()
      }
      .padding()
      .onTapGesture {}

      HStack {
        Image(systemName: "cart")
        Text(LocalizedString.purchases)
        Spacer()
      }
      .padding()
      .onTapGesture {}
    }
    .foregroundStyle(.primary)
    .frame(width: LayoutConstant.disclosureViewWidth)
  }
}

protocol SideMenuViewDelegate: AnyObject {
  func didTapUserProfile()
  func didTapBookmarks()
  func didTapJobs()
  func didTapFollowerRequests()
  func didTapSettingsAndPrivacy()
  func didTapUserFollowRelationsButton(userName: String)
}

private let fakeUser = createFakeUser()
#Preview {
  SideMenuView(
    userName: fakeUser.userName, numOfFollowing: fakeUser.numOfFollowing,
    numOfFollowers: fakeUser.numOfFollowers)
}
