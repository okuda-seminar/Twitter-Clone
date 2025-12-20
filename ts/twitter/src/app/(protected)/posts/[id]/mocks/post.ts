import type { Post } from "@/lib/models/post";

export const mockPost: Post = {
  type: "post",
  id: "123",
  authorId: "456",
  text: "sample post",
  createdAt: "2024-01-01",
};
