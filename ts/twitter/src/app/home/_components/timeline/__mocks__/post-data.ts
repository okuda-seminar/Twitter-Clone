import { GetCollectionOfPostsBySpecificUserAndUsersTheyFollowResponse } from "@/lib/models/post";

export const mockPosts: GetCollectionOfPostsBySpecificUserAndUsersTheyFollowResponse =
  [
    {
      id: "post-123",
      user_id: "user-789",
      text: "test text",
      created_at: "2024-01-01",
    },
  ];
