import Foundation

/// The completion typealias for the fetchSearchedTagCandidateUsers method.
public typealias didFetchSearchedTagCandidateUsersCompletion = ([SearchedUserModel]) -> (Void)
/// The completion typealias for the startListeningToSSECompletion method.
public typealias didStartListeningToTimelineSSECompletion = (
  Result<(TimelineSSEEventType, [PostModel]), Error>
) ->
  Void

/// The enum to represent the errors in the PostService.
private enum PostServiceError: Error {
  case invalidURL
  case dataProcessingError
}

/// The service class to handle post-related operations, such as repost or fetching post-related data.
public final class PostService: NSObject {

  // MARK: - Public Props

  /// The singleton instance of PostService for shared usage.
  public static let shared = PostService()

  /// The collection of delegates that will be notified about post-related action changes.
  public var delegates = [PostServiceDelegate]()

  // MARK: - Private Props

  /// The task responsible for downloading data with server-sent events.
  private var timelineSseTask: URLSessionDataTask?

  /// The session responsible for managing the server-sent events connection.
  private var timelineSseSession: URLSession?

  /// The completion handler responsible for handling server-sent events results.
  private var timelineSseCompletion: didStartListeningToTimelineSSECompletion?

  /// The base URL used for making network requests.
  private let baseURL: String = "http://localhost:80"

  // MARK: - Public API

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

  /// Starts listening to an server-sent events connection for timeline-related updates for the user with the given id.
  ///
  /// - Parameters:
  ///   - id: The id of the user whose timeline updates will be received.
  ///   - completion: The closure to be called with the result of the timeline event results.
  public func startListeningToTimelineSSE(
    id: String, completion: @escaping didStartListeningToTimelineSSECompletion
  ) {
    guard let url = URL(string: "\(baseURL)/api/users/\(id)/timelines/reverse_chronological") else {
      completion(.failure(PostServiceError.invalidURL))
      return
    }

    let request = configureRequest(url: url)
    timelineSseSession = configureSession()
    timelineSseTask = timelineSseSession?.dataTask(with: request)
    timelineSseCompletion = { result in
      completion(result)
    }
    print("Start listening to timeline SSE connection...")
    timelineSseTask?.resume()
  }

  /// Stops listening to server-sent events for timeline-related updates.
  public func stopListeningToTimelineSSE() {
    timelineSseTask?.cancel()
    timelineSseSession?.invalidateAndCancel()
    timelineSseTask = nil
    timelineSseSession = nil
    timelineSseCompletion = nil
    print("Stop listening to timeline SSE connection")
  }

  // MARK: - Private API

  /// Configures the request for the server-sent events connection with the provided url.
  ///
  /// - Parameter url: The provided url to configure the request for.
  /// - Returns: The configured request for the SSE connection.
  private func configureRequest(url: URL) -> URLRequest {
    var request = URLRequest(url: url)
    request.setValue("text/event-stream", forHTTPHeaderField: "Accept")
    return request
  }

  /// Configures the session for the server-sent events connection.
  ///
  /// - Returns: The configured session for the server-sent events.
  private func configureSession() -> URLSession {
    let sessionConfig = URLSessionConfiguration.default
    sessionConfig.timeoutIntervalForRequest = TimeInterval.infinity
    sessionConfig.timeoutIntervalForResource = TimeInterval.infinity
    return URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
  }

  /// Handles the payload from a server-sent events, parsing the data and calling the completion handler.
  ///
  /// - Parameters:
  ///   - data: The data received in the server-sent events.
  ///   - completion: The closure to be called with the result of the server-sent events.
  private func handleTimelineSSEEventPayload(
    _ data: Data, completion: @escaping didStartListeningToTimelineSSECompletion
  ) {
    guard let eventString = String(data: data, encoding: .utf8) else {
      completion(.failure(PostServiceError.dataProcessingError))
      return
    }

    // Remove the "data:" event field prefix.
    let eventField: String = "data:"
    let cleanedEventString =
      eventString.hasPrefix(eventField)
      ? String(eventString.dropFirst(eventField.count)) : eventString

    guard let eventJsonData = cleanedEventString.data(using: .utf8) else {
      completion(.failure(PostServiceError.dataProcessingError))
      return
    }

    do {
      let decodedEventData = try JSONDecoder().decode(
        TimelineSSEDataModel.self, from: eventJsonData)

      let posts = decodedEventData.posts.map {
        convertTimelineSSEPostModelToPostModel(ssePostModel: $0)
      }

      DispatchQueue.main.async {
        switch decodedEventData.eventType {
        case .timelineAccessed:
          completion(.success((.timelineAccessed, posts)))
        case .postCreated:
          completion(.success((.postCreated, posts)))
        case .postDeleted:
          completion(.success((.postDeleted, posts)))
        }
      }
    } catch {
      print(error.localizedDescription)
      completion(.failure(PostServiceError.dataProcessingError))
    }
  }
}

extension PostService: URLSessionDataDelegate {

  /// Starts handling an server-sent events payload when new data is received from the connection.
  ///
  /// - Parameters:
  ///   - session: The URLSession instance managing the task.
  ///   - dataTask: The task responsible for downloading data.
  ///   - data: The data received from the server.
  public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data)
  {
    guard let completion = timelineSseCompletion else { return }
    handleTimelineSSEEventPayload(data, completion: completion)
  }
}

/// The protocol that defines methods for handling actions related to posts in the PostService.
public protocol PostServiceDelegate: AnyObject {
  func didRepost(postModelId: UUID)
}

/// Injects the shared instance of PostService.
///
/// - Returns: The singleton instance of PostService.
public func InjectPostService() -> PostService {
  return PostService.shared
}
