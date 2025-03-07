import Foundation

protocol BookmarkService {
  func fetchCurrentBookmarks() -> [PostModel]
}

private class BookmarkServiceImplementation: BookmarkService {
  fileprivate static let shared = BookmarkServiceImplementation()

  func fetchCurrentBookmarks() -> [PostModel] {
    var bookmarkedPosts = [PostModel]()
    for _ in 0..<30 {
      bookmarkedPosts.append(createFakePostModel())
    }
    return bookmarkedPosts
  }
}

func injectBookmarkService() -> BookmarkService {
  return BookmarkServiceImplementation.shared
}
