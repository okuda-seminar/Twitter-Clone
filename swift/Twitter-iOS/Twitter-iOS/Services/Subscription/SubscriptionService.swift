import Foundation

enum SubscriptionPrice: Int, CaseIterable {
  case basic = 600
  case premium = 1380
  case premiumPlus = 3000

  static var allCases: [SubscriptionPrice] = [.basic, .premium, .premiumPlus]
}

protocol SubscriptionService {
  func fetchPrices() -> [SubscriptionPrice]
}

class SubscriptionServiceImplementation: SubscriptionService {
  fileprivate static let shared = SubscriptionServiceImplementation()

  func fetchPrices() -> [SubscriptionPrice] {
    return SubscriptionPrice.allCases
  }
}

func injectSubscriptionService() -> SubscriptionService {
  return SubscriptionServiceImplementation.shared
}
