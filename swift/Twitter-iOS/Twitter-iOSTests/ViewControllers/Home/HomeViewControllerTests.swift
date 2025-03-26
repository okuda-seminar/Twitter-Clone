import XCTest

@testable import Twitter_iOS

final class HomeViewControllerTests: XCTestCase {
  private var sut: HomeViewController!
  private var fakeTimelinePostsDataSource: TimelinePostsDataSource!

  override func setUpWithError() throws {
    fakeTimelinePostsDataSource = createFakeTimelinePostsDataSource()
    sut = HomeViewController(postsDataSource: fakeTimelinePostsDataSource)
  }

  override func tearDownWithError() throws {
    sut = nil
    fakeTimelinePostsDataSource = nil
  }

  /// Simulates view controller appearance lifecycle.
  private func simulateViewControllerAppearance() {
    let timeInterval: TimeInterval = 0.1
    sut.beginAppearanceTransition(true, animated: false)
    sut.endAppearanceTransition()

    // Runs the loop to ensure async operations are processed.
    RunLoop.main.run(until: Date(timeIntervalSinceNow: timeInterval))
  }

  /// Tests timeline Server-sent events handling when TimelineAccessed event is received.
  func testViewDidAppearWhenReceivedTimelineAccessedEventType() {
    let responseData: [PostModel] = [createFakePostModel(), createFakePostModel()]

    if let fakeService = injectTimelineService() as? FakeTimelineService {
      fakeService.configureFakeTimelineService(
        simulationType: .timelineAccessed, responsePostsData: responseData)
    }

    let expectedPostsData: [PostModel] = responseData

    simulateViewControllerAppearance()

    XCTAssertEqual(
      expectedPostsData, self.fakeTimelinePostsDataSource.followingTabPostModels,
      "The count of followingTabPostModels should be \(expectedPostsData.count), but was \(self.fakeTimelinePostsDataSource.followingTabPostModels.count)."
    )
  }

  /// Tests timeline Server-sent events handling when PostCreated event is received.
  func testViewDidAppearWhenReceivedPostCreatedEventType() {
    let responseData: [PostModel] = [createFakePostModel()]
    fakeTimelinePostsDataSource.followingTabPostModels = []

    if let fakeService = injectTimelineService() as? FakeTimelineService {
      fakeService.configureFakeTimelineService(
        simulationType: .postCreated, responsePostsData: responseData)
    }

    let expectedPostsData: [PostModel] = responseData

    simulateViewControllerAppearance()

    XCTAssertEqual(
      expectedPostsData, self.fakeTimelinePostsDataSource.followingTabPostModels,
      "The count of followingTabPostModels should be \(expectedPostsData.count), but was \(self.fakeTimelinePostsDataSource.followingTabPostModels.count)."
    )
  }

  /// Tests timeline Server-sent events handling when PostDeleted event is received.
  func testViewDidAppearWhenReceivedPostDeletedEventType() {
    let responseData: [PostModel] = [createFakePostModel()]
    fakeTimelinePostsDataSource.followingTabPostModels = responseData

    if let fakeService = injectTimelineService() as? FakeTimelineService {
      fakeService.configureFakeTimelineService(
        simulationType: .postDeleted, responsePostsData: responseData)
    }

    simulateViewControllerAppearance()

    XCTAssertTrue(
      self.fakeTimelinePostsDataSource.followingTabPostModels.isEmpty,
      "followingTabPostModels should be empty, but still contains \(self.fakeTimelinePostsDataSource.followingTabPostModels.count) postModels."
    )
  }

  /// Tests timeline Server-sent events handling when an invalid URL error is received.
  func testViewDidAppearWhenReceivedInvalidURLError() {
    // Embed the HomeViewController in a window to be able to present an alert.
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = sut
    window.makeKeyAndVisible()

    if let fakeService = injectTimelineService() as? FakeTimelineService {
      fakeService.configureFakeTimelineService(
        simulationType: .invalidURLError, responsePostsData: [])
    }

    simulateViewControllerAppearance()

    guard let alert = sut.presentedViewController as? UIAlertController else {
      XCTFail(
        "Expected an alert controller to be presented, but got \(String(describing: sut.presentedViewController))"
      )
      return
    }

    let expectedAlertTitle = String(localized: "Invalid URL Error")
    let expectedAlertMessage = String(
      localized: "The server URL is invalid. Please try again later or contact support.")
    let expectedAlertActionTitle = String(localized: "OK")

    XCTAssertEqual(
      expectedAlertTitle, alert.title,
      "Alert title should be \(expectedAlertTitle), but got \(alert.title ?? "nil").")
    XCTAssertEqual(
      expectedAlertMessage, alert.message,
      "Alert message should be \(expectedAlertMessage), but got \(alert.message ?? "nil").")
    let actionTitles = alert.actions.compactMap { $0.title }
    XCTAssertEqual(
      expectedAlertActionTitle, actionTitles.first,
      "Alert action title should be \(expectedAlertActionTitle), but got \(actionTitles.first ?? "nil")."
    )
  }

  /// Tests timeline Server-sent events handling when a data processing error is received.
  func testViewDidAppearWhenReceivedDataProcessingError() {
    // Embed the HomeViewController in a window to be able to present an alert.
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = sut
    window.makeKeyAndVisible()

    if let fakeService = injectTimelineService() as? FakeTimelineService {
      fakeService.configureFakeTimelineService(
        simulationType: .dataProcessingError, responsePostsData: [])
    }

    simulateViewControllerAppearance()

    guard let alert = sut.presentedViewController as? UIAlertController else {
      XCTFail(
        "Expected an alert controller to be presented, but got \(String(describing: sut.presentedViewController))"
      )
      return
    }

    let expectedAlertTitle = String(localized: "Data Error")
    let expectedAlertMessage = String(
      localized:
        "The data from the server could not be processed. Please try again later or contact support."
    )
    let expectedAlertActionTitle = String(localized: "OK")

    XCTAssertEqual(
      expectedAlertTitle, alert.title,
      "Alert title should be \(expectedAlertTitle), but got \(alert.title ?? "nil").")
    XCTAssertEqual(
      expectedAlertMessage, alert.message,
      "Alert message should be \(expectedAlertMessage), but got \(alert.message ?? "nil").")
    let actionTitles = alert.actions.compactMap { $0.title }
    XCTAssertEqual(
      expectedAlertActionTitle, actionTitles.first,
      "Alert action title should be \(expectedAlertActionTitle), but got \(actionTitles.first ?? "nil")."
    )
  }
}
