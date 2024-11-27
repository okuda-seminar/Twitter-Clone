export interface Post {
  id: string;
  user_id: string;
  text: string;
  created_at: string;
}

export type GetCollectionOfPostsBySpecificUserAndUsersTheyFollowResponse =
  Post[];
