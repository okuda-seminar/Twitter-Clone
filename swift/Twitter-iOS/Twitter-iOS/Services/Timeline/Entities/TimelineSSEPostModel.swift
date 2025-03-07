import UIKit

/// The model representing a post received from the timeline Server-sent events connection.
public struct TimelineSSEPostModel: Identifiable, Codable {
  public let id: UUID
  let userId: String
  let text: String
  let createdAt: String

  enum CodingKeys: String, CodingKey {
    case id
    case userId = "user_id"
    case text
    case createdAt = "created_at"
  }
}

/// Converts a post response into a PostModel for rendering posts in the UI.
///
/// - Parameter postResponse: The post received from the timeline Server-sent events connection.
/// - Returns: The PostModel instance used for rendering posts in the UI.
public func convertTimelinePostResponseToPostModel(postResponse: TimelineSSEPostModel) -> PostModel
{
  return PostModel(
    id: postResponse.id,
    bodyText: postResponse.text,
    userIcon: UIImage(systemName: "apple.logo")!,  // Safe to unwrap.
    userName: "Apple",
    isRepostedByCurrentUser: false
  )
}
