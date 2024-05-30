import SwiftUI
import UIKit

class SideMenuViewController: UIViewController {
  var user = createFakeUser()

  public weak var sideMenuViewDelegate: SideMenuViewDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    let hostingController = UIHostingController(
      rootView: SideMenuView(
        userName: user.userName, numOfFollowing: user.numOfFollowing,
        numOfFollowers: user.numOfFollowers, delegate: sideMenuViewDelegate))
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(hostingController)
    hostingController.didMove(toParent: self)
    view.addSubview(hostingController.view)

    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }
}

struct SideMenuView: View {
  public var userName: String
  public var numOfFollowing: Int
  public var numOfFollowers: Int
  public weak var delegate: SideMenuViewDelegate?

  private enum LayoutConstant {
    static let imageSize = 20.0
  }

  private enum LocalizedString {
    static let following = String(localized: "Following")
    static let followers = String(localized: "Followers")
    static let profile = String(localized: "Profile")
    static let bookmarks = String(localized: "Bookmarks")
    static let lists = String(localized: "Lists")
    static let spaces = String(localized: "Spaces")
    static let followerRequests = String(localized: "Follower Requests")
    static let monetization = String(localized: "Monetization")
    static let settingsAndSupport = String(localized: "Settings and Support")
    static let settingsAndPrivacy = String(localized: "Settings and privacy")
  }

  var body: some View {
    VStack(alignment: .leading) {
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
          Text("@\(userName)")
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

      Divider()
        .padding(.bottom)

      HStack {
        Image(systemName: "person")
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
        Text(LocalizedString.profile)
      }
      .onTapGesture {
        delegate?.didTapUserProfile()
      }

      HStack {
        // We need to align image aspects in prod.
        Image(systemName: "bookmark")
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
        Text(LocalizedString.bookmarks)
      }.onTapGesture {
        delegate?.didTapBookmarks()
      }
      HStack {
        // We need to align image aspects in prod.
        Image(systemName: "list.clipboard")
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
        Text(LocalizedString.lists)
      }
      HStack {
        // We need to align image aspects in prod.
        Image(systemName: "mic")
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
        Text(LocalizedString.spaces)
      }
      HStack {
        // We need to align image aspects in prod.
        Image(systemName: "person.badge.plus")
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
        Text(LocalizedString.followerRequests)
      }.onTapGesture {
        delegate?.didTapFollowerRequests()
      }
      HStack {
        // We need to align image aspects in prod.
        Image(systemName: "bitcoinsign.circle")
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
        Text(LocalizedString.monetization)
      }

      Divider()
        .padding(.top)

      Text(LocalizedString.settingsAndSupport)

      HStack {
        Image(systemName: "gear")
        Text(LocalizedString.settingsAndPrivacy)
      }
      .padding()
      .onTapGesture {
        delegate?.didTapSettingsAndPrivacy()
      }
    }
    .padding()
  }
}

protocol SideMenuViewDelegate: AnyObject {
  func didTapUserProfile()
  func didTapBookmarks()
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
