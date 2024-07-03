import Foundation

final class SearchInputDataSource: ObservableObject {
  @Published var recentlySearchedUsers = [SearchedUserModel]()
}

func createFakeSearchInputDataSource() -> SearchInputDataSource {
  let dataSource = SearchInputDataSource()
  var recentlySearchedUsers = [SearchedUserModel]()
  for _ in 0..<10 {
    recentlySearchedUsers.append(createFakeSearchedUserModel())
  }
  dataSource.recentlySearchedUsers = recentlySearchedUsers
  return dataSource
}
