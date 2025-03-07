import Foundation

protocol FollowService {
  func followerRequestingUsers() -> [UserModel]
}

class FollowServiceImplementation: FollowService {
  static let sharedInstance = FollowServiceImplementation()

  public func followerRequestingUsers() -> [UserModel] {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/264
    // - Fetch follower requesting users from backend.
    var users: [UserModel] = []
    for _ in 0..<10 {
      users.append(createFakeUser())
    }
    return users
  }
}

class FakeFollowService: FollowService {
  static let sharedInstance = FakeFollowService()

  public func followerRequestingUsers() -> [UserModel] {
    return [createFakeUser()]
  }
}

func injectFollowService() -> FollowService {
  if isRunningUnitTests() {
    return FakeFollowService.sharedInstance
  }
  return FollowServiceImplementation.sharedInstance
}
