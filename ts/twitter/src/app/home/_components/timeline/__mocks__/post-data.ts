import { TimelineEventResponse } from "../timeline-feed-service";

export const mockPosts: TimelineEventResponse[] = [
  {
    event_type: "TimelineAccessed",
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
    event_type: "PostCreated",
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
