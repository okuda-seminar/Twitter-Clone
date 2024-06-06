import SwiftUI

struct UserModel: Identifiable {
  let id: UUID
  let icon: Image
  let userName: String
  let bio: String
  let numOfFollowing: Int
  let numOfFollowers: Int
}

func createFakeUser() -> UserModel {
  return UserModel(
    id: UUID(),
    icon: Image(systemName: "apple.logo"),
    userName: "fakeUserName",
    bio: "Apple.com",
    numOfFollowing: 1,
    numOfFollowers: 0
  )
}
