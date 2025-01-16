import { TimelineEventResponse, TimelineEventType } from "../use-timeline-feed";

export const mockPosts: TimelineEventResponse[] = [
  {
    event_type: TimelineEventType.TimelineAccessed,
    posts: [
      {
        id: "post-123",
        user_id: "user-789",
        text: "test text",
        created_at: "2024-01-01",
      },
    ],
  },
  {
    event_type: TimelineEventType.PostCreated,
    posts: [
      {
        id: "post-123",
        user_id: "user-789",
        text: "created post",
        created_at: "2024-01-02",
      },
    ],
  },
];
