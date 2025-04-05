import Foundation
import UIKit

/// The enum representing different types of events received from the timeline Server-sent events connection.
public enum TimelineEventType: String, Codable {
  case timelineAccessed = "TimelineAccessed"
  case postCreated = "PostCreated"
  case postDeleted = "PostDeleted"
  case RepostCreated = "RepostCreated"
  case RepostDeleted = "RepostDeleted"
  case QuoteRepostCreated = "QuoteRepostCreated"
}

/// Struct to hold event details
struct TimelineEventModel: Codable {
  let eventType: TimelineEventType
  let timelineItems: [TimelineEventItemModel]
  let posts: String?
  let reposts: String?

  enum CodingKeys: String, CodingKey {
    case eventType = "event_type"
    case timelineItems = "timeline_items"
    case posts
    case reposts
  }
}

struct TimelineEventItemModel: Codable {
  let type: String
  let id: String
  let authorId: String
  let text: String
  let createdAt: String
  let parentPostId: String?

  var postModel: TimelinePostModel? {
    guard type == "post" else { return nil }
    return TimelinePostModel(
      type: type,
      id: id,
      authorId: authorId,
      text: text,
      createdAt: createdAt
    )
  }

  var repostModel: TimelineRepostModel? {
    guard type == "repost", let parentId = parentPostId else { return nil }
    return TimelineRepostModel(
      id: id,
      parentId: parentId,
      userId: authorId,
      text: text,
      createdAt: createdAt
    )
  }
}

/// Base struct for Post
struct TimelinePostModel: Codable {
  let type: String
  let id: String
  let authorId: String
  let text: String
  let createdAt: String

  var clientPostModel: PostModel? {
    guard let uuid = UUID(uuidString: id) else { return nil }
    return PostModel(id: uuid, bodyText: text, userIcon: UIImage(), userName: "TBU", isRepostedByCurrentUser: false)
  }
}

/// Timeline struct for Repost
struct TimelineRepostModel: Codable {
  let id: String
  let parentId: String
  let userId: String
  let text: String
  let createdAt: String

  enum CodingKeys: String, CodingKey {
    case id
    case parentId = "parent_id"
    case userId = "user_id"
    case text
    case createdAt = "created_at"
  }
}
