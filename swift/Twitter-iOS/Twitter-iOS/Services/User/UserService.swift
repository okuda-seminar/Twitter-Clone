import Foundation

public final class UserService {

  // MARK: - Public variable

  public static let sharedInstance = UserService()

  // MARK: - Public API

  public func followUser(_ userName: String) {
    print("Followed \(userName).")
  }

  public func unfollowUser(_ userName: String) {
    print("Unfollowed \(userName)")
  }

  public func muteUser(_ userName: String) {
    print("Muted \(userName)")
  }

  public func unmuteUser(_ userName: String) {
    print("Unmuted \(userName)")
  }

  public func blockUser(_ userName: String) {
    print("Blocked \(userName)")
  }
}
