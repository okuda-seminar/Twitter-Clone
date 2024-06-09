import SwiftUI

struct UserConnectWhoToFollowView: View {
  private static let sectionTitle = String(localized: "Suggested for you")

  private var suggestedUsers: [UserModel] = {
    var users: [UserModel] = []
    for _ in 0..<30 {
      users.append(createFakeUser())
    }
    return users
  }()

  var body: some View {

    ScrollView(.vertical) {
      VStack {
        HStack {
          Text(Self.sectionTitle)
          Spacer()
        }
        .padding(.leading)

        ForEach(suggestedUsers) { user in
          UserOverviewCell(userModel: user)
        }
      }
    }
  }
}

#Preview {
  UserConnectWhoToFollowView()
}
