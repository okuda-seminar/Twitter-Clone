import SwiftUI
import UIKit

class UserFollowerRequestsPageViewController: UIViewController {

  private enum LocalizedString {
    static let title = String(localized: "Follower requests")
  }

  private lazy var hostingController: UIHostingController = {
    let followService = InjectFollowService()
    let controller = UIHostingController(
      rootView: UserFollowerRequestsView(
        followerRequestingUsers: followService.followerRequestingUsers()))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print("\(className) viewDidAppear")
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    print("\(className) viewDidDisappear")
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("\(className) viewWillAppear")
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    print("\(className) viewWillDisappear")
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

    // set up navigation
    navigationItem.backButtonDisplayMode = .minimal
    navigationItem.title = LocalizedString.title
    navigationController?.navigationBar.backgroundColor = .systemBackground
  }
}

struct UserFollowerRequestsView: View {
  public let followerRequestingUsers: [UserModel]

  private enum LayoutConstant {
    static let userIconSize: CGFloat = 48.0

    static let roundedButtonPadding: CGFloat = 12.0
    static let roundedButtonIconSize: CGFloat = 16.0
    static let roundedButtonLineWidth: CGFloat = 1.5

    static let headlineFontSize: CGFloat = 29.0
    static let subHeadlineFontSize: CGFloat = 15.0
    static let headlineViewSpacing: CGFloat = 10.0
    static let headlineViewTopPadding: CGFloat = 50.0
  }

  private enum LocalizedString {
    static let headlineText = String(localized: "You're up to date")
    static let subHeadlineText = String(
      localized:
        "When someone requests to follow you, it'll show up here for you to accept or decline."
    )
  }

  var body: some View {
    if followerRequestingUsers.count > 0 {
      ScrollView(.vertical) {
        VStack {
          ForEach(followerRequestingUsers) { userModel in
            FollowerRequestingUserCell(userModel: userModel)
          }
        }
        Spacer()
      }
    } else {
      FollowerReuqestsPageWithoutData()
    }
  }

  @ViewBuilder
  private func FollowerRequestingUserCell(userModel: UserModel) -> some View {
    HStack(alignment: .top) {
      Image(uiImage: userModel.icon)
        .resizable()
        .scaledToFit()
        .frame(width: LayoutConstant.userIconSize, height: LayoutConstant.userIconSize)

      VStack(alignment: .leading) {
        Text(userModel.name)
        Text(userModel.userName)
          .foregroundStyle(Color(uiColor: .brandedLightGrayText))
      }

      Spacer()

      Button(
        action: {

        },
        label: {
          Image(systemName: "checkmark")
            .resizable()
            .scaledToFit()
            .frame(
              width: LayoutConstant.roundedButtonIconSize,
              height: LayoutConstant.roundedButtonIconSize
            )
            .foregroundStyle(.primary)
            .padding(LayoutConstant.roundedButtonPadding)
            .clipShape(Circle())
            .overlay {
              Circle()
                .stroke(
                  Color(uiColor: .brandedLightGrayBackground),
                  lineWidth: LayoutConstant.roundedButtonLineWidth)
            }
        }
      )
      .buttonStyle(.plain)

      Button(
        action: {

        },
        label: {
          Image(systemName: "multiply")
            .resizable()
            .scaledToFit()
            .frame(
              width: LayoutConstant.roundedButtonIconSize,
              height: LayoutConstant.roundedButtonIconSize
            )
            .foregroundStyle(Color(uiColor: .systemRed))
            .padding(LayoutConstant.roundedButtonPadding)
            .clipShape(Circle())
            .overlay {
              Circle()
                .stroke(
                  Color(uiColor: .systemRed),
                  lineWidth: LayoutConstant.roundedButtonLineWidth)
            }
        }
      )
      .buttonStyle(.plain)
    }
    .padding()
  }

  @ViewBuilder
  private func FollowerReuqestsPageWithoutData() -> some View {
    VStack(alignment: .leading, spacing: LayoutConstant.headlineViewSpacing) {
      Text(LocalizedString.headlineText)
        .font(.system(size: LayoutConstant.headlineFontSize, weight: .heavy))

      Text(LocalizedString.subHeadlineText)
        .font(.system(size: LayoutConstant.subHeadlineFontSize))
        .foregroundStyle(.gray)

      Spacer()
    }
    .padding(.top, LayoutConstant.headlineViewTopPadding)
    .padding(.horizontal)
  }
}

#Preview {
  UserFollowerRequestsView(followerRequestingUsers: [createFakeUser()])
}
