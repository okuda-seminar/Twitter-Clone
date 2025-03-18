import Foundation

/// The data source of posts data for each tab in HomeViewController.
final class TimelinePostsDataSource: ObservableObject {
  @Published var forYouTabPostModels: [PostModel] = []
  @Published var followingTabPostModels: [PostModel] = []
}

/// Create a timeline posts data source for preview and testing purposes.
///
/// - Returns: The TimelinePostsDataSource instance with sample data.
func createFakeTimelinePostsDataSource() -> TimelinePostsDataSource {
  let dataSource = TimelinePostsDataSource()

  var forYouTabPostModels = [PostModel]()
  for _ in 0..<30 {
    forYouTabPostModels.append(createFakePostModel())
  }
  dataSource.forYouTabPostModels = forYouTabPostModels

  var followingTabPostModels = [PostModel]()
  for _ in 0..<30 {
    followingTabPostModels.append(createFakePostModel())
  }
  dataSource.followingTabPostModels = followingTabPostModels

  return dataSource
}
