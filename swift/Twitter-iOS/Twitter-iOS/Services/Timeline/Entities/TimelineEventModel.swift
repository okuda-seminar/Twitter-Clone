import Foundation
import UIKit

/// The enum representing different types of events received from the timeline Server-sent events connection.
public enum TimelineEventType: String, Codable {
  case timelineAccessed = "TimelineAccessed"
  case postCreated = "PostCreated"
  case postDeleted = "PostDeleted"
  case repostCreated = "RepostCreated"
  case repostDeleted = "RepostDeleted"
  case quoteRepostCreated = "QuoteRepostCreated"
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
  let id: UUID
  let authorId: UUID
  let text: String?
  let createdAt: String
  let parentPostId: ParentPostId?

  var postModel: TimelinePostModel? {
    guard type == "post", let text else { return nil }
    return TimelinePostModel(
      type: type,
      id: id,
      authorId: authorId,
      text: text,
      createdAt: createdAt
    )
  }

  var repostModel: TimelineRepostModel? {
    guard type == "repost", let parentPostId else { return nil }
    return TimelineRepostModel(
      id: id,
      parentPostId: parentPostId,
      userId: authorId,
      createdAt: createdAt
    )
  }
}

/// Base struct for Post
struct TimelinePostModel: Codable {
  let type: String
  let id: UUID
  let authorId: UUID
  let text: String
  let createdAt: String

  var clientPostModel: PostModel? {
    return PostModel(
      id: id, bodyText: text, userIcon: UIImage(), userName: "TBU", isRepostedByCurrentUser: false
    )
  }
}

/// Timeline struct for Repost
struct TimelineRepostModel: Codable {
  let id: UUID
  let parentPostId: ParentPostId
  let userId: UUID
  let createdAt: String

  var clientRepostModel: RepostModel? {
    RepostModel(
      id: id,
      post: .init(
        id: parentPostId.uuid, bodyText: "Repost!", userIcon: UIImage(), userName: "",
        isRepostedByCurrentUser: true))
  }
}

/// Represents the nested parentPostId object
struct ParentPostId: Codable, Hashable {
  let uuid: UUID
  let isValid: Bool

  enum CodingKeys: String, CodingKey {
    case uuid = "UUID"
    case isValid = "Valid"
  }
}
