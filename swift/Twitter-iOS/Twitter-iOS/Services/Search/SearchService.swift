import Foundation

protocol SearchService {
  func fetchRecentSearchedUsers(completion: FetchRecentSearchedUsersCompletion)
  func fetchRecentSearchedQueries(completion: FetchRecentSearchedQueriesCompletion)
  func removeRecentlySearchedQuery(_ removedQuery: String)
}

typealias FetchRecentSearchedUsersCompletion = ([SearchedUserModel]) -> (Void)
typealias FetchRecentSearchedQueriesCompletion = ([SearchedQueryModel]) -> (Void)

class SearchServiceImplementation: SearchService {
  static let shared = SearchServiceImplementation()

  func fetchRecentSearchedUsers(completion: FetchRecentSearchedUsersCompletion) {
    var searchedUsers = [SearchedUserModel]()
    for _ in 0..<30 {
      searchedUsers.append(createFakeSearchedUserModel())
    }
    completion(searchedUsers)
  }

  func fetchRecentSearchedQueries(completion: FetchRecentSearchedQueriesCompletion) {
    var searchedQueries = [SearchedQueryModel]()
    for _ in 0..<10 {
      searchedQueries.append(createFakeSearchedQueryModel())
    }
    completion(searchedQueries)
  }

  func removeRecentlySearchedQuery(_ removedQuery: String) {
    print("Sending a request to remove \(removedQuery)")
  }
}

func injectSearchService() -> SearchService {
  return SearchServiceImplementation.shared
}
