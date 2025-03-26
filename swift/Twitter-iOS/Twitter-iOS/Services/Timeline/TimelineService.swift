import Foundation

/// The completion typealias for the startListeningToTimelineSSE method.
public typealias didStartListeningToTimelineSSECompletion = (
  Result<(TimelineSSEEventType, [PostModel]), Error>
) -> Void

/// The enum to represent the errors in TimelineService.
public enum TimelineServiceError: Error {
  case invalidURLError
  case dataProcessingError
}

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/612
// - Implement Unit Tests for TimelineService.

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/615
// - Implement Reconnection Logic for SSE Connection in TimelineService.
/// The service class to handle timeline-related operations.
public final class TimelineService: NSObject, TimelineServiceProtocol {

  // MARK: - Public Props

  /// The singleton instance of TimelineService for shared usage.
  public static let shared = TimelineService()

  // MARK: - Private Props

  /// The task responsible for downloading data from the Server-sent events connection.
  private var timelineSSETask: URLSessionDataTask?

  /// The session responsible for managing the Server-sent events connection.
  private var timelineSSESession: URLSession?

  /// The completion handler responsible for handling results from the Server-sent events connection.
  private var timelineSSECompletion: didStartListeningToTimelineSSECompletion?

  /// The base URL used for making network requests.
  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/610
  // - Centralize Base URL Configuration Across Services.
  private static let baseURL: String = "http://localhost:80"

  // MARK: - Public API

  /// Starts listening to the Server-sent events connection for timeline-related updates for the user with the given id.
  ///
  /// - Parameters:
  ///   - id: The id of the user whose timeline updates will be received.
  ///   - completion: The closure to be called with the result of the timeline event results.
  public func startListeningToTimelineSSE(
    id: String, completion: @escaping didStartListeningToTimelineSSECompletion
  ) {
    guard
      let url = URL(
        string: "\(TimelineService.baseURL)/api/users/\(id)/timelines/reverse_chronological")
    else {
      completion(.failure(TimelineServiceError.invalidURLError))
      return
    }

    let request = configureRequest(url: url)
    timelineSSESession = configureSession()
    timelineSSETask = timelineSSESession?.dataTask(with: request)
    timelineSSECompletion = { result in
      completion(result)
    }

    timelineSSETask?.resume()
  }

  /// Stops listening to the Server-sent events connection for timeline-related updates.
  public func stopListeningToTimelineSSE() {
    timelineSSETask?.cancel()
    timelineSSESession?.invalidateAndCancel()
    timelineSSETask = nil
    timelineSSESession = nil
    timelineSSECompletion = nil
  }

  // MARK: - Private API

  /// Configures the request for the Server-sent events connection with the provided url.
  ///
  /// - Parameter url: The provided url to configure the request for.
  /// - Returns: The configured request for the SSE connection.
  private func configureRequest(url: URL) -> URLRequest {
    var request = URLRequest(url: url)
    request.setValue("text/event-stream", forHTTPHeaderField: "Accept")
    return request
  }

  /// Configures the session for the Server-sent events connection.
  ///
  /// - Returns: The configured session for the Server-sent events connection.
  private func configureSession() -> URLSession {
    let sessionConfig = URLSessionConfiguration.default
    sessionConfig.timeoutIntervalForRequest = TimeInterval.infinity
    sessionConfig.timeoutIntervalForResource = TimeInterval.infinity
    return URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
  }

  /// Handles the payload from the Server-sent events, parsing the data and calling the completion handler.
  ///
  /// - Parameters:
  ///   - data: The data received from the server.
  ///   - completion: The closure to be called with the result of the events.
  private func handleTimelineSSEEventPayload(
    _ data: Data, completion: @escaping didStartListeningToTimelineSSECompletion
  ) {
    guard let eventString = String(data: data, encoding: .utf8) else {
      completion(.failure(TimelineServiceError.dataProcessingError))
      return
    }

    // Remove the "data:" event field prefix.
    let eventField: String = "data:"
    let cleanedEventString =
      eventString.hasPrefix(eventField)
      ? String(eventString.dropFirst(eventField.count)) : eventString

    guard let eventJsonData = cleanedEventString.data(using: .utf8) else {
      completion(.failure(TimelineServiceError.dataProcessingError))
      return
    }

    do {
      let decodedEventData = try JSONDecoder().decode(
        TimelineSSEDataModel.self, from: eventJsonData)

      let posts = decodedEventData.posts.map {
        convertTimelinePostResponseToPostModel(postResponse: $0)
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
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/611
      // - Add Robust Error Handling for Timeline SSE Processing.
      print(error.localizedDescription)
      completion(.failure(TimelineServiceError.dataProcessingError))
    }
  }
}

extension TimelineService: URLSessionDataDelegate {

  /// Starts handling the Server-sent events payload when new data is received from the connection.
  ///
  /// - Parameters:
  ///   - session: The URLSession instance managing the task.
  ///   - dataTask: The task responsible for downloading data.
  ///   - data: The data received from the server.
  public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data)
  {
    guard let completion = timelineSSECompletion else { return }
    handleTimelineSSEEventPayload(data, completion: completion)
  }
}

/// Injects the shared instance of TimelineService.
///
/// - Returns: The singleton instance of TimelineService.
public func injectTimelineService() -> TimelineService {
  return TimelineService.shared
}

/// The Protocol for Dependency Injection of TimelineService.
protocol TimelineServiceProtocol {
  func startListeningToTimelineSSE(
    id: String, completion: @escaping didStartListeningToTimelineSSECompletion)
  func stopListeningToTimelineSSE()
}
