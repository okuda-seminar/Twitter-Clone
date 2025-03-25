import Foundation

class MockSSEURLSession: URLSession, @unchecked Sendable {
  public var resumeClosure: (() -> Void)?

  override func dataTask(with request: URLRequest) -> URLSessionDataTask {
    return MockSSEURLSessionDataTask { [weak self] in
      self?.resumeClosure?()
    }
  }

  override func invalidateAndCancel() {
    resumeClosure = nil
  }
}
