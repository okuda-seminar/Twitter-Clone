"use server";

import { ok, err, ServerActionsResult, ServerActionsError } from "./types";

interface CreatePostBody {
  user_id: string;
  text: string;
}

interface CreatePostResponse {
  id: string;
  user_id: string;
  text: string;
  created_at: string;
}

export async function createPost(
  body: CreatePostBody
): Promise<ServerActionsResult<CreatePostResponse, ServerActionsError>> {
  const res = await fetch(`${process.env.API_BASE_URL}/api/posts`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(body),
  });

  if (res.ok) {
    const data: CreatePostResponse = await res.json();
    return ok(data);
  } else {
    return err({
      status: res.status,
      statusText: res.statusText,
    });
  }
}
