import Foundation

@testable import Twitter_iOS

/// A fake timeline service that supports both success and error scenarios for test cases.
public class FakeTimelineService: TimelineServiceProtocol {

  // MARK: - Public Props

  /// The singleton instance of FakeTimelineService for shared usage.
  public static let shared = FakeTimelineService()

  /// The simulation type used to determine the behavior of the fake timeline service.
  public enum SimulationType {
    case timelineAccessed
    case postCreated
    case postDeleted
    case invalidURLError
    case dataProcessingError
  }

  // MARK: - Private Props

  /// The current simulation type. Defaults to `.timelineAccessed`.
  private var simulationType: SimulationType = .timelineAccessed

  /// The response posts data to be used when a successful event is simulated.
  private var responsePostsData: [PostModel] = []

  // MARK: - Public API

  /// Configures the fake timeline service with the desired simulation type and response data.
  ///
  /// - Parameters:
  ///   - eventType: The simulation type that determines which response or error is returned.
  ///   - responsePostsData: The post models to return in a successful scenario.
  public func configureFakeTimelineService(
    simulationType: SimulationType, responsePostsData: [PostModel]
  ) {
    self.simulationType = simulationType
    self.responsePostsData = responsePostsData
  }

  /// Starts listening to the timeline SSE and triggers the completion handler based on the simulation type.
  ///
  /// - Parameters:
  ///   - id: The id used for the timeline SSE connection.
  ///   - completion: A closure to be called when the SSE event simulation completes.
  public func startListeningToTimelineSSE(
    id: String, completion: @escaping didStartListeningToTimelineSSECompletion
  ) {
    switch simulationType {
    case .timelineAccessed:
      completion(.success((TimelineSSEEventType.timelineAccessed, responsePostsData)))
    case .postCreated:
      completion(.success((TimelineSSEEventType.postCreated, responsePostsData)))
    case .postDeleted:
      completion(.success((TimelineSSEEventType.postDeleted, responsePostsData)))
    case .invalidURLError:
      completion(.failure(TimelineServiceError.invalidURLError))
    case .dataProcessingError:
      completion(.failure(TimelineServiceError.dataProcessingError))
    }
  }

  /// Stops listening to the timeline SSE.
  public func stopListeningToTimelineSSE() {}
}

/// Injects the shared instance of FakeTimelineService.
///
/// - Returns: The singleton instance of FakeTimelineService.
public func injectFakeTimelineService() -> FakeTimelineService {
  return FakeTimelineService.shared
}
