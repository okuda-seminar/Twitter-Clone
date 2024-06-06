import SwiftUI

struct UserFollowingTabView: View {

  private let followingUsers: [UserModel] = {
    var userModels: [UserModel] = []
    for _ in 0..<10 {
      userModels.append(createFakeUser())
    }
    return userModels
  }()

  var body: some View {
    ScrollView {
      VStack {
        ForEach(followingUsers) { userModel in
          FollowingUserCellView(userModel: userModel)
        }
      }
    }
  }
}

struct FollowingUserCellView: View {
  public var userModel: UserModel

  private enum LayoutConstant {
    static let iconSize: CGFloat = 48.0

    static let followButtonCornerRadius: CGFloat = 24.0
    static let followButtonBorderLineWidth: CGFloat = 3.0
  }
  private static let following = String(localized: "Following")

  var body: some View {
    HStack(alignment: .top) {
      userModel.icon
        .resizable()
        .scaledToFit()
        .frame(width: LayoutConstant.iconSize, height: LayoutConstant.iconSize)

      VStack(alignment: .leading) {
        HStack {
          VStack {
            Text(userModel.userName)
            Text("@\(userModel.userName)")
          }

          Spacer()

          Button(
            action: {
              print("Unfollow is tapped.")
            },
            label: {
              Text(Self.following)
                .underline()
                .padding()
            }
          )
          .foregroundStyle(.primary)
          .overlay {
            RoundedRectangle(cornerRadius: LayoutConstant.followButtonCornerRadius)
              .stroke(
                Color(uiColor: .brandedLightGrayBackground),
                lineWidth: LayoutConstant.followButtonBorderLineWidth)
          }
        }
        Text(userModel.bio)
      }
    }
    .padding()
  }
}

#Preview {
  UserFollowingTabView()
}
