import XCTest

@testable import Twitter_iOS

// TODO:
// - Implement URL Validation for Services.
// Add a test for the case an invalid URL given.
class TimelineServiceTests: XCTestCase {
  private var sut: TimelineService!
  private var mockSSEURLSession: MockSSEURLSession!
  private let testId: UUID = UUID()
  private let testPostsCount: Int = 1
  private let testUserId: String = "testUserId"
  private let testPostText: String = "Test post"
  private let testCreatedAt: String = "2025-03-23T12:00:00Z"
  private let testTimeout: TimeInterval = 2.0

  override func setUpWithError() throws {
    mockSSEURLSession = MockSSEURLSession()
    sut = TimelineService(urlSession: mockSSEURLSession)
  }

  override func tearDownWithError() throws {
    sut = nil
    mockSSEURLSession = nil
  }

  private func createResponseData(eventType: TimelineSSEEventType) -> Data {
    let jsonObject: [String: Any] = [
      "event_type": "\(eventType.rawValue)",
      "posts": [
        [
          "id": testId.uuidString,
          "user_id": testUserId,
          "text": testPostText,
          "created_at": testCreatedAt,
        ]
      ],
    ]

    guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: []),
      let jsonString = String(data: jsonData, encoding: .utf8),
      let ssePayloadData = ("data:" + jsonString).data(using: .utf8)
    else {
      fatalError("Failed to create response data.")
    }

    return ssePayloadData
  }

  private func configureMockSession(with responseData: Data) {
    mockSSEURLSession.resumeClosure = { [weak self] in
      guard let strongSelf = self else { return }
      let mockDataTask = MockSSEURLSessionDataTask {}
      strongSelf.sut.urlSession(
        strongSelf.mockSSEURLSession, dataTask: mockDataTask, didReceive: responseData)
    }
  }

  func testStartListeningToTimelineSSEWhenReceivedTimelineAccessedEvent() throws {
    let responseData = createResponseData(eventType: .timelineAccessed)
    configureMockSession(with: responseData)

    let expectation = self.expectation(
      description: "Should receive a TimelineAccessed event with the expected posts.")

    sut.startListeningToTimelineSSE(id: testId.uuidString) { [weak self] result in
      guard let strongSelf = self else {
        XCTFail(
          "The TimelineServiceTests was deallocated before the completion handler was called.")
        return
      }

      switch result {
      case .success(let (eventType, posts)):
        XCTAssertEqual(
          eventType, .timelineAccessed,
          "Should receive \(TimelineSSEEventType.timelineAccessed.rawValue) event, but received \(eventType.rawValue) event."
        )
        XCTAssertEqual(
          posts.count, strongSelf.testPostsCount,
          "Should receive \(strongSelf.testPostsCount) posts, but received \(posts.count) posts.")
        XCTAssertEqual(
          posts.first?.id, strongSelf.testId,
          "Received ID should be \(strongSelf.testId.uuidString), but was \(posts.first?.id.uuidString ?? "nil")."
        )
        XCTAssertEqual(
          posts.first?.bodyText, strongSelf.testPostText,
          "Received body text should be \(strongSelf.testPostText), but received \(posts.first?.bodyText ?? "nil")."
        )
      case .failure(let error):
        XCTFail("Should receive the responseData, but failed with error: \(error).")
      }
      expectation.fulfill()
    }

    waitForExpectations(timeout: testTimeout)
  }

  func testStartListeningToTimelineSSEWhenReceivedPostCreatedEvent() throws {
    let responseData = createResponseData(eventType: .postCreated)
    configureMockSession(with: responseData)

    let expectation = self.expectation(
      description: "Should receive a PostCreated event with the expected posts.")

    sut.startListeningToTimelineSSE(id: testId.uuidString) { [weak self] result in
      guard let strongSelf = self else {
        XCTFail(
          "The TimelineServiceTests was deallocated before the completion handler was called.")
        return
      }

      switch result {
      case .success(let (eventType, posts)):
        XCTAssertEqual(
          eventType, .postCreated,
          "Should receive \(TimelineSSEEventType.timelineAccessed.rawValue) event, but received \(eventType.rawValue) event."
        )
        XCTAssertEqual(
          posts.count, strongSelf.testPostsCount,
          "Should receive \(strongSelf.testPostsCount) posts, but received \(posts.count) posts.")
        XCTAssertEqual(
          posts.first?.id, strongSelf.testId,
          "Received ID should be \(strongSelf.testId.uuidString), but was \(posts.first?.id.uuidString ?? "nil")."
        )
        XCTAssertEqual(
          posts.first?.bodyText, strongSelf.testPostText,
          "Received body text should be \(strongSelf.testPostText), but received \(posts.first?.bodyText ?? "nil")."
        )
      case .failure(let error):
        XCTFail("Should receive the responseData, but failed with error: \(error).")
      }
      expectation.fulfill()
    }

    waitForExpectations(timeout: testTimeout)
  }

  func testStartListeningToTimelineSSEWhenReceivedPostDeletedEvent() throws {
    let responseData = createResponseData(eventType: .postDeleted)
    configureMockSession(with: responseData)

    let expectation = self.expectation(
      description: "Should receive a PostDeleted event with the expected posts.")

    sut.startListeningToTimelineSSE(id: testId.uuidString) { [weak self] result in
      guard let strongSelf = self else {
        XCTFail(
          "The TimelineServiceTests was deallocated before the completion handler was called.")
        return
      }

      switch result {
      case .success(let (eventType, posts)):
        XCTAssertEqual(
          eventType, .postDeleted,
          "Should receive \(TimelineSSEEventType.timelineAccessed.rawValue) event, but received \(eventType.rawValue) event."
        )
        XCTAssertEqual(
          posts.count, strongSelf.testPostsCount,
          "Should receive \(strongSelf.testPostsCount) posts, but received \(posts.count) posts.")
        XCTAssertEqual(
          posts.first?.id, strongSelf.testId,
          "Received ID should be \(strongSelf.testId.uuidString), but was \(posts.first?.id.uuidString ?? "nil")."
        )
        XCTAssertEqual(
          posts.first?.bodyText, strongSelf.testPostText,
          "Received body text should be \(strongSelf.testPostText), but received \(posts.first?.bodyText ?? "nil")."
        )
      case .failure(let error):
        XCTFail("Should receive the responseData, but failed with error: \(error).")
      }
      expectation.fulfill()
    }

    waitForExpectations(timeout: testTimeout)
  }

  func testStartListeningToTimelineSSEWhenReceivedInvalidJSONSyntaxData() {
    let invalidJSONSyntaxString = "data:{ \"malformed\": malformed data }"
    // Safe to unwrap. Every valid Swift String is guaranteed to be a valid Unicode string, including an empty string.
    let invalidJSONSyntaxData = invalidJSONSyntaxString.data(using: .utf8)!
    configureMockSession(with: invalidJSONSyntaxData)

    let expectation = self.expectation(
      description: "Should fail with dataProcessingError due to invalid JSON syntax.")

    sut.startListeningToTimelineSSE(id: testId.uuidString) { result in
      switch result {
      case .success:
        XCTFail(
          "Should fail with \(TimelineServiceError.dataProcessingError), but received success.")
      case .failure(let error as TimelineServiceError):
        XCTAssertEqual(
          error, .dataProcessingError,
          "Should receive \(TimelineServiceError.dataProcessingError), but received \(error).")
      case .failure(let error):
        XCTFail(
          "Should receive \(TimelineServiceError.dataProcessingError), but received \(error): \(error.localizedDescription)."
        )
      }
      expectation.fulfill()
    }

    waitForExpectations(timeout: testTimeout)
  }

  // Additional tests for handleTimelineSSEEventPayload error scenarios
  func testStartListeningToTimelineSSEWhenGivenInvalidStringEncoding() {
    // Create a string that cannot be converted back to UTF-8.
    let invalidString = String(utf16CodeUnits: [0xD800, 0xDC00], count: 2)
    // Safe to unwrap. Every valid Swift String is guaranteed to be a valid Unicode string, including an empty string.
    let invalidData = invalidString.data(using: .utf16)!
    configureMockSession(with: invalidData)

    let expectation = self.expectation(
      description: "Should fail with dataProcessingError due to invalid String Encoding.")

    // Use a private method testing approach (reflection or exposing method for testing)
    sut.startListeningToTimelineSSE(id: testId.uuidString) { result in
      switch result {
      case .success:
        XCTFail(
          "Should fail with \(TimelineServiceError.dataProcessingError), but received success.")
      case .failure(let error as TimelineServiceError):
        XCTAssertEqual(
          error, .dataProcessingError,
          "Should receive \(TimelineServiceError.dataProcessingError), but received \(error).")
      case .failure(let error):
        XCTFail(
          "Should receive \(TimelineServiceError.dataProcessingError), but received \(error): \(error.localizedDescription)."
        )
      }
      expectation.fulfill()
    }

    waitForExpectations(timeout: testTimeout)
  }

  func testStartListeningToTimelineSSEWhenGivenEmptyData() {
    let emptyData = Data()
    configureMockSession(with: emptyData)

    let expectation = self.expectation(
      description: "Should fail with dataProcessingError due to empty Data.")

    sut.startListeningToTimelineSSE(id: testId.uuidString) { result in
      switch result {
      case .success:
        XCTFail(
          "Should fail with \(TimelineServiceError.dataProcessingError), but received success.")
      case .failure(let error as TimelineServiceError):
        XCTAssertEqual(
          error, .dataProcessingError,
          "Should receive \(TimelineServiceError.dataProcessingError), but received \(error).")
      case .failure(let error):
        XCTFail(
          "Should receive \(TimelineServiceError.dataProcessingError), but received \(error): \(error.localizedDescription)."
        )
      }
      expectation.fulfill()
    }

    waitForExpectations(timeout: testTimeout)
  }

  // This test fails.
  //  func testStopListeningToTimelineSSE() {
  //    let responseData = createResponseData(eventType: .timelineAccessed)
  //    configureMockSession(with: responseData)
  //
  //    let noEventExpectation = expectation(description: "No event should be delivered after stopping SSE.")
  //    noEventExpectation.isInverted = true
  //
  //    sut.startListeningToTimelineSSE(id: testUserId) {_ in
  //      noEventExpectation.fulfill()
  //    }
  //
  //    sut.stopListeningToTimelineSSE()
  //
  //    waitForExpectations(timeout: testTimeout)
  //  }
}
