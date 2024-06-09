import UIKit

func isRunningUnitTests() -> Bool {
  return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
}
