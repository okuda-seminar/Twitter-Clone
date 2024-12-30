import SwiftUI
import UIKit

struct SideMenuView: View {
  public var userName: String
  public var numOfFollowing: Int
  public var numOfFollowers: Int
  public weak var delegate: SideMenuViewDelegate?

  private enum LayoutConstant {
    static let imageSize: CGFloat = 20.0
    static let disclosureViewWidth: CGFloat = 250.0
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
        //         Current Implementation
        Task {
          await delegate?.userProfileDidReceiveTap()
        }

        // Other Implementations
        //        delegate?.userProfileDidReceiveTap()
      },
      label: {
        Image(systemName: "person.circle.fill")
          .resizable()
          .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
          .foregroundStyle(.black)
      })

    Button(
      action: {
        // Current Implementation
        Task {
          await delegate?.userProfileDidReceiveTap()
        }

        // Other Implementations
        //        delegate?.userProfileDidReceiveTap()
      },
      label: {
        Text(userName)
      }
    )
    .foregroundStyle(.primary)

    HStack {
      Button(
        action: {
          delegate?.userFollowRelationsButtonDidReceiveTap(userName: userName)
        },
        label: {
          Text("\(numOfFollowing) \(LocalizedString.following)")
            .foregroundStyle(.black)
        })

      Button(
        action: {
          delegate?.userFollowRelationsButtonDidReceiveTap(userName: userName)
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
        // Current Implementation
        Task {
          await delegate?.userProfileDidReceiveTap()
        }

        // Other Implementations
        //        delegate?.userProfileDidReceiveTap()
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
        delegate?.bookmarksDidReceiveTap()
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
        delegate?.jobsDidReceiveTap()
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
        delegate?.listsDidReceiveTap()
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
        delegate?.followerRequestsDidReceiveTap()
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
        delegate?.settingsAndPrivacyDidReceiveTap()
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
  // Current Implementation
  func userProfileDidReceiveTap() async

  // Other Implementations
  // func userProfileDidReceiveTap()
  func bookmarksDidReceiveTap()
  func jobsDidReceiveTap()
  func listsDidReceiveTap()
  func followerRequestsDidReceiveTap()
  func settingsAndPrivacyDidReceiveTap()
  func userFollowRelationsButtonDidReceiveTap(userName: String)
}

private let fakeUser = createFakeUser()
#Preview {
  SideMenuView(
    userName: fakeUser.userName, numOfFollowing: fakeUser.numOfFollowing,
    numOfFollowers: fakeUser.numOfFollowers)
}
