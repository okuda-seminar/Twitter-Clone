import SwiftUI

/// The model representing a post.
public struct PostModel: Identifiable {
  public let id: UUID
  let bodyText: String
  let userIcon: UIImage
  let userName: String
  let isRepostedByCurrentUser: Bool
}

extension PostModel: Equatable {
  public static func == (lhs: PostModel, rhs: PostModel) -> Bool {
    return lhs.id == rhs.id
      && lhs.bodyText == rhs.bodyText
      && lhs.userIcon == rhs.userIcon
      && lhs.userName == rhs.userName
      && lhs.isRepostedByCurrentUser == rhs.isRepostedByCurrentUser
  }
}

/// Create a fake post model for preview and testing purposes.
///
/// - Returns: The PostModel instance with sample data.
func createFakePostModel() -> PostModel {
  return PostModel(
    id: UUID(),
    bodyText:
      """
      Use a binding to create a two-way connection between a property that stores data,
      and a view that displays and changes the data. [Wikipedia](https://www.wikipedia.org)
      """,
    userIcon: UIImage(systemName: "apple.logo")!,  // Safe to unwrap
    userName: "Apple",
    isRepostedByCurrentUser: false
  )
}
