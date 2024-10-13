import Foundation

public typealias FetchSearchedTagCandidateUsersCompletion = ([SearchedUserModel]) -> (Void)

public final class PostService {
  public static let shared = PostService()
  public var delegates = [PostServiceDelegate]()

  public func repost(postModelId: UUID) {
    // Need to send requests to server first in the future.
    for delegate in delegates {
      delegate.didRepost(postModelId: postModelId)
    }
  }

  public func fetchSearchedTagCandidateUsers(completion: FetchSearchedTagCandidateUsersCompletion) {
    var searchedUsers = [SearchedUserModel]()
    for _ in 0..<30 {
      searchedUsers.append(createFakeSearchedUserModel())
    }
    completion(searchedUsers)
  }
}

public protocol PostServiceDelegate: AnyObject {
  func didRepost(postModelId: UUID)
}

public func InjectPostService() -> PostService {
  return PostService.shared
}
