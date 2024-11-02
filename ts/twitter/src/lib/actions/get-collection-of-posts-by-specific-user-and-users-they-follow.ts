"use server";

import { Post } from "../models/post";

interface GetCollectionOfPostsBySpecificUserAndUsersTheyFollowBody {
  user_id: string;
}

export type GetCollectionOfPostsBySpecificUserAndUsersTheyFollowResponse =
  Post[];

export async function getCollectionOfPostsBySpecificUserAndUsersTheyFollow({
  user_id,
}: GetCollectionOfPostsBySpecificUserAndUsersTheyFollowBody): Promise<GetCollectionOfPostsBySpecificUserAndUsersTheyFollowResponse> {
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
      const responseData: GetCollectionOfPostsBySpecificUserAndUsersTheyFollowResponse =
        await res.json();
      return responseData;
    } else {
      throw new Error(`Failed to find post: ${res.status} ${res.statusText}`);
    }
  } catch (error) {
    throw new Error("Unable to find post. Please try again later.");
  }
}
