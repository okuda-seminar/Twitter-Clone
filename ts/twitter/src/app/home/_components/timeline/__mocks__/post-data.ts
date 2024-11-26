import { FollowingPostsResponse } from "@/lib/actions/fetch-following-posts";

export const mockPosts: FollowingPostsResponse = [
  {
    id: "post-123",
    user_id: "user-789",
    text: "test text",
    created_at: "2024-01-01",
  },
];
