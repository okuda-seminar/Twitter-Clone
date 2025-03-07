import Foundation

/// The enum representing different types of events received from the timeline Server-sent events connection.
public enum TimelineSSEEventType: String, Codable {
  case timelineAccessed = "TimelineAccessed"
  case postCreated = "PostCreated"
  case postDeleted = "PostDeleted"
}

/// The model representing data received from the timeline Server-sent events connection.
public struct TimelineSSEDataModel: Codable {
  let eventType: TimelineSSEEventType
  let posts: [TimelineSSEPostModel]

  enum CodingKeys: String, CodingKey {
    case eventType = "event_type"
    case posts
  }
}
