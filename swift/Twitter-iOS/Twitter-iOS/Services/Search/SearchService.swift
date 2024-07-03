import Foundation

protocol SearchService {
  func fetchRecentSearches(completion: FetchRecentSearchesCompletion)
}

typealias FetchRecentSearchesCompletion = ([SearchedUserModel]) -> (Void)

class SearchServiceImplementation: SearchService {
  static let shared = SearchServiceImplementation()

  func fetchRecentSearches(completion: FetchRecentSearchesCompletion) {
    var searchedUsers = [SearchedUserModel]()
    for _ in 0..<30 {
      searchedUsers.append(createFakeSearchedUserModel())
    }
    completion(searchedUsers)
  }
}

func injectSearchService() -> SearchService {
  return SearchServiceImplementation.shared
}
