"use server";

import {
  type ServerActionsError,
  type ServerActionsResult,
  err,
  ok,
} from "./types";

interface CreatePostBody {
  text: string;
}

interface CreatePostResponse {
  id: string;
  user_id: string;
  text: string;
  created_at: string;
}

export async function createPost(
  userId: string,
  body: CreatePostBody,
): Promise<ServerActionsResult<CreatePostResponse, ServerActionsError>> {
  const res = await fetch(
    `${process.env.NEXT_PUBLIC_LOCAL_API_BASE_URL}/api/users/${userId}/posts`,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ text: body.text }),
    },
  );

  if (res.ok) {
    const data: CreatePostResponse = await res.json();
    return ok(data);
  }

  return err({
    status: res.status,
    statusText: res.statusText,
  });
}
