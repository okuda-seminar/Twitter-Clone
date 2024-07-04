import Foundation

final class SearchInputDataSource: ObservableObject {
  @Published var recentlySearchedUsers = [SearchedUserModel]()
  @Published var recentlySearchedQueries = [SearchedQueryModel]()
}

func createFakeSearchInputDataSource() -> SearchInputDataSource {
  let dataSource = SearchInputDataSource()
  var recentlySearchedUsers = [SearchedUserModel]()
  for _ in 0..<10 {
    recentlySearchedUsers.append(createFakeSearchedUserModel())
  }
  dataSource.recentlySearchedUsers = recentlySearchedUsers

  var recentlySearchedQueries = [SearchedQueryModel]()
  for _ in 0..<10 {
    recentlySearchedQueries.append(createFakeSearchedQueryModel())
  }
  dataSource.recentlySearchedQueries = recentlySearchedQueries
  return dataSource
}
