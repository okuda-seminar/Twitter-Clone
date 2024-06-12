import SwiftUI

class UserModel: Identifiable {
  let id: UUID
  let icon: UIImage
  let name: String
  let userName: String
  let isPrivateAccount: Bool
  let bio: String
  let numOfFollowing: Int
  let numOfFollowers: Int

  public init(
    id: UUID, icon: UIImage, name: String, userName: String, isPrivateAccount: Bool, bio: String,
    numOfFollowing: Int,
    numOfFollowers: Int
  ) {
    self.id = id
    self.icon = icon
    self.name = name
    self.userName = userName
    self.isPrivateAccount = isPrivateAccount
    self.bio = bio
    self.numOfFollowing = numOfFollowing
    self.numOfFollowers = numOfFollowers
  }
}

func createFakeUser() -> UserModel {
  return UserModel(
    id: UUID(),
    icon: UIImage(systemName: "apple.logo")!,  // Safe to force unwrap
    name: "Apple",
    userName: "@apple",
    isPrivateAccount: false,
    bio: "Apple.com",
    numOfFollowing: 1,
    numOfFollowers: 0
  )
}

/// Probably need to replace class with protocol in the future.
class CurrentUser: UserModel {
  public static let shared = CurrentUser(
    id: UUID(),
    icon: UIImage(systemName: "apple.logo")!,  // Safe to force unwrap
    name: "Apple",
    userName: "@apple",
    isPrivateAccount: true,
    bio: "Apple.com",
    numOfFollowing: 1,
    numOfFollowers: 0)

  public var isLoggedIn = false
}

final class FakeCurrentUser: CurrentUser {}

private func createFakeCurrentUser() -> FakeCurrentUser {
  return FakeCurrentUser(
    id: UUID(),
    icon: UIImage(systemName: "apple.logo")!,  // Safe to force unwrap
    name: "Apple",
    userName: "@apple",
    isPrivateAccount: true,
    bio: "Apple.com",
    numOfFollowing: 1,
    numOfFollowers: 0)
}

func InjectCurrentUser() -> CurrentUser {
  if isRunningUnitTests() {
    return createFakeCurrentUser()
  }
  return CurrentUser.shared
}
