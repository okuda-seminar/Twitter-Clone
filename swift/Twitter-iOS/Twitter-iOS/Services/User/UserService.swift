import Foundation

public typealias UserServiceCompletion = (_ success: Bool) -> Void

public final class UserService {

  // MARK: - Public variable

  public static let sharedInstance = UserService()

  // MARK: - Public API

  public func followUser(_ userName: String, completion: UserServiceCompletion? = nil) {
    print("Followed \(userName).")
    if let completion {
      completion(true)
    }
  }

  public func unfollowUser(_ userName: String, completion: UserServiceCompletion? = nil) {
    print("Unfollowed \(userName)")
    if let completion {
      completion(true)
    }
  }

  public func muteUser(_ userName: String, completion: UserServiceCompletion? = nil) {
    print("Muted \(userName)")
    if let completion {
      completion(true)
    }
  }

  public func unmuteUser(_ userName: String, completion: UserServiceCompletion? = nil) {
    print("Unmuted \(userName)")
    if let completion {
      completion(true)
    }
  }

  public func blockUser(_ userName: String, completion: UserServiceCompletion? = nil) {
    print("Blocked \(userName)")
    if let completion {
      completion(true)
    }
  }
}
