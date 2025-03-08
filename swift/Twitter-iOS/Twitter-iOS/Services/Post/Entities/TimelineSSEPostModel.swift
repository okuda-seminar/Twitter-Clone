import UIKit

/// The model representing a post received from the timeline server-sent events connection.
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

/// Converts an TimelineSSEPostModel into a PostModel used for rendering posts in the UI.
///
/// - Parameter ssePostModel: The model of a post received from the timeline server-sent events connection.
/// - Returns: The PostModel instance used for rendering posts in the UI.
public func convertTimelineSSEPostModelToPostModel(ssePostModel: TimelineSSEPostModel) -> PostModel
{
  return PostModel(
    id: ssePostModel.id,
    bodyText: ssePostModel.text,
    userIcon: UIImage(systemName: "apple.logo")!,  // Safe to unwrap.
    userName: "Apple",
    isRepostedByCurrentUser: false
  )
}
