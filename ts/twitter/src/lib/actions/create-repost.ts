"use server";

import {
  type ServerActionsError,
  type ServerActionsResult,
  err,
  ok,
} from "./types";

interface CreateRepostBody {
  post_id: string;
}

interface CreateRepostResponse {
  id: string;
  authorId: string;
  parentPostId: {
    UUID: string;
    Valid: boolean;
  };
  type: string;
  createdAt: string;
}

export async function createRepost(
  userId: string,
  body: CreateRepostBody,
): Promise<ServerActionsResult<CreateRepostResponse, ServerActionsError>> {
  const res = await fetch(
    `${process.env.NEXT_PUBLIC_LOCAL_API_BASE_URL}/api/users/${userId}/reposts`,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ post_id: body.post_id }),
    },
  );

  if (res.ok) {
    const data: CreateRepostResponse = await res.json();
    return ok(data);
  }

  return err({
    status: res.status,
    statusText: res.statusText,
  });
}
