import Foundation
import os

import Apollo
import TwitterGraphql

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/615
// - Implement Reconnection Logic for SSE Connection in TimelineService.
/// The service class to handle timeline-related operations.
public final class TimelineService: NSObject {

  private let apolloClient = ApolloClient(url: URL(string: "\(TimelineService.baseURL)/graphql")!)

  // MARK: - Public Props

  /// The singleton instance of TimelineService for shared usage.
  public static let shared = TimelineService()

  // MARK: - Private Props

  /// The task responsible for downloading data from the Server-sent events connection.
  private var timelineSSETask: URLSessionDataTask?

  /// The session responsible for managing the Server-sent events connection.
  private var timelineSSESession: URLSession?

  /// The base URL used for making network requests.
  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/610
  // - Centralize Base URL Configuration Across Services.
  private static let baseURL: String = "http://localhost:3000"

  private let logger = os.Logger(subsystem: "com.x-clone", category: "timelineService")

  // MARK: - Public API
  public func fetchTimelineData(completionHandler: @escaping ([TimelineQuery.Data.GetReverseChronologicalHomeTimeline]) -> Void) {
    let timelineQuery = TimelineQuery(userId: "57df39ee-4ad2-412c-a678-47ded33541f7")
    var responseData: [TimelineQuery.Data.GetReverseChronologicalHomeTimeline] = []
    apolloClient.fetch(query: timelineQuery) { [weak self] result in
      // 3. Handle the result in the closure
      switch result {
      case .success(let graphQLResult):
        if let data = graphQLResult.data {
          responseData = data.getReverseChronologicalHomeTimeline
        } else if let errors = graphQLResult.errors {
          // Handle GraphQL errors (e.g., validation errors)
          self?.logger.debug("GraphQL Errors: \(errors)")
        } else {
          self?.logger.debug("Unknown Error")
        }

      case .failure(let error):
        // Handle network errors or client-side issues
        self?.logger.debug("Network Error: \(error)")
      }
      completionHandler(responseData)
    }
  }

  // MARK: - Private API
}

/// Injects the shared instance of TimelineService.
///
/// - Returns: The singleton instance of TimelineService.
public func injectTimelineService() -> TimelineService {
  return TimelineService.shared
}
