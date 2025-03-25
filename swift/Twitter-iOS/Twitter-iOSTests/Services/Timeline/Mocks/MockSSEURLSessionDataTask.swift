import Foundation

class MockSSEURLSessionDataTask: URLSessionDataTask, @unchecked Sendable {
  private var resumeClosure: (() -> Void)?

  init(resumeClosure: @escaping () -> Void) {
    self.resumeClosure = resumeClosure
  }

  override func resume() {
    resumeClosure?()
  }

  override func cancel() {
    resumeClosure = nil
  }
}
