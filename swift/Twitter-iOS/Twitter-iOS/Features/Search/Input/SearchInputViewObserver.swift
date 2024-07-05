import Foundation

typealias didRemoveRecentlySearchQueryCompletion = (_ removedQuery: String) -> Void

class SearchInputViewObserver: ObservableObject {
  var didRemoveRecentlySearchQuery: didRemoveRecentlySearchQueryCompletion?
}
