import Foundation
import os

/// The completion typealias for the fetchSearchedTagCandidateUsers method.
public typealias didFetchSearchedTagCandidateUsersCompletion = ([SearchedUserModel]) -> (Void)

/// The service class to handle post-related operations.
public final class PostService {

  // MARK: - Public Props

  /// The singleton instance of PostService for shared usage.
  public static let shared = PostService()

  /// The collection of delegates that will be notified about post-related action changes.
  public var delegates = [PostServiceDelegate]()

  // MARK: - Private Props

  private static let baseURLString = "http://localhost:80"

  private let logger = os.Logger(subsystem: "com.x-clone", category: "postService")

  // MARK: - Public API

  public func post(_ post: PostModel) async {
    guard let url = URL(string: "\(Self.baseURLString)/api/posts") else { return }
    let request = CreatePostRequest(
      userId: injectAuthService().currentUser.id.uuidString, text: post.bodyText)
    guard let jsonData = try? JSONEncoder().encode(request) else { return }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    urlRequest.httpBody = jsonData

    do {
      let (_, response) = try await URLSession.shared.data(for: urlRequest)
      if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
        logger.info("Post created: \(httpResponse)")
      }
    } catch {}
  }

  /// Reposts the post with the given post model id.
  ///
  /// - Parameter postModelId: The id of the given post to repost.
  public func repost(postModelId: UUID) {
    // Need to send requests to server first in the future.
    for delegate in delegates {
      delegate.didRepost(postModelId: postModelId)
    }
  }

  /// Fetches a list of the searched tag canditate users.
  ///
  /// - Parameter completion: The closure to be called with the list of the fetched users.
  public func fetchSearchedTagCandidateUsers(
    completion: didFetchSearchedTagCandidateUsersCompletion
  ) {
    var searchedUsers = [SearchedUserModel]()
    for _ in 0..<30 {
      searchedUsers.append(createFakeSearchedUserModel())
    }
    completion(searchedUsers)
  }
}

/// The protocol that defines methods for handling post-related actions in PostService.
public protocol PostServiceDelegate: AnyObject {
  func didRepost(postModelId: UUID)
}

/// Injects the shared instance of PostService.
///
/// - Returns: The singleton instance of PostService.
public func injectPostService() -> PostService {
  return PostService.shared
}
