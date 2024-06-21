import Foundation

public final class PostService {
  public static let shared = PostService()
  public var delegates = [PostServiceDelegate]()

  public func repost(postModelId: UUID) {
    // Need to send requests to server first in the future.
    for delegate in delegates {
      delegate.didRepost(postModelId: postModelId)
    }
  }
}

public protocol PostServiceDelegate: AnyObject {
  func didRepost(postModelId: UUID)
}

public func InjectPostService() -> PostService {
  return PostService.shared
}
