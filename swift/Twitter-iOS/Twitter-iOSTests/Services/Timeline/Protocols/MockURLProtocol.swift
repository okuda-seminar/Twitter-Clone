//import Foundation
//
//class MockURLProtocol: URLProtocol {
//  static var stubResponseData: Data?
//  static var error: Error?
//
//  override class func canInit(with request: URLRequest) -> Bool {
//    return true
//  }
//
//  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
//    return request
//  }
//
//  override func startLoading() {
//    if let strongError = MockURLProtocol.error {
//      self.client?.urlProtocol(self, didFailWithError: strongError)
//    } else {
//      self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
//    }
//
//    self.client?.urlProtocolDidFinishLoading(self)
//  }
//
//  override func stopLoading() {}
//}

// In Unit Test...
//  override func setUpWithError() throws {
//    let configuration = URLSessionConfiguration.ephemeral
//    configuration.protocolClasses = [MockURLProtocol.self]
//    // I think I need to assign a delegate to URLSession here, but even though I assign it,
//    // I'm not able to access handleTimelineSSEEventPayload from outside the class because the method is private.
//    let mockURLSession = URLSession(configuration: configuration)
//    sut = TimelineService(urlSession: mockURLSession)
//
//    MockURLProtocol.stubResponseData = nil
//    MockURLProtocol.error = nil
//  }
