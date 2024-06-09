import SwiftUI

struct UserOverviewCell: View {
  public var userModel: UserModel

  private static let followText = String(localized: "Follow")

  var body: some View {
    HStack(alignment: .top) {
      userModel.icon
        .resizable()
        .scaledToFit()
        .frame(width: 48, height: 48)

      VStack(alignment: .leading) {
        HStack {
          VStack(alignment: .leading) {
            Text(userModel.userName)
            Text("@\(userModel.userName)")
          }

          Spacer()

          Button {

          } label: {
            Text(Self.followText)
              .underline()
              .foregroundStyle(.white)
              .padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24))
              .background(.black)
              .clipShape(Capsule())
          }
          .buttonStyle(.plain)
        }
        Text(userModel.bio)
      }
    }
    .padding()
  }
}

#Preview {
  UserOverviewCell(userModel: createFakeUser())
}
