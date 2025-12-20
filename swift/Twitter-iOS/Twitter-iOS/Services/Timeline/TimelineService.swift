import Foundation
import os


// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/615
// - Implement Reconnection Logic for SSE Connection in TimelineService.
/// The service class to handle timeline-related operations.
public final class TimelineService: NSObject {

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
  private static let baseURL: String = "http://localhost:80"

  private let logger = os.Logger(subsystem: "com.x-clone", category: "timelineService")

  // MARK: - Public API
  

  // MARK: - Private API
}

/// Injects the shared instance of TimelineService.
///
/// - Returns: The singleton instance of TimelineService.
public func injectTimelineService() -> TimelineService {
  return TimelineService.shared
}
