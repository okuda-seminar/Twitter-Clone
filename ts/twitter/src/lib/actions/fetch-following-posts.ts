"use server";

/**
 * Fetches posts for the user's timeline, including:
 * - Posts by the logged-in user
 * - Posts by users the logged-in user follows
 *
 * Note: The content types may be expanded in the future.
 */

import { Post } from "../models/post";

interface FollowingPostsBody {
  user_id: string;
}

export type FollowingPostsResponse = Post[];

export async function fetchFollowingPosts({
  user_id,
}: FollowingPostsBody): Promise<FollowingPostsResponse> {
  try {
    const res = await fetch(
      `${process.env.API_BASE_URL}/api/users/${user_id}/timelines/reverse_chronological`,
      {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        },

        cache: "no-store",
      }
    );

    if (res.ok) {
      const responseData: FollowingPostsResponse = await res.json();
      return responseData;
    } else {
      throw new Error(`Failed to find post: ${res.status} ${res.statusText}`);
    }
  } catch (error) {
    throw new Error("Unable to find post. Please try again later.");
  }
}
