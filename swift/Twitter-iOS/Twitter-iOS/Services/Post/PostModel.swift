import SwiftUI

/// The model representing a post.
public struct PostModel: Identifiable {
  public let id: UUID
  let bodyText: String
  let userIcon: UIImage
  let userName: String
  let isRepostedByCurrentUser: Bool
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
