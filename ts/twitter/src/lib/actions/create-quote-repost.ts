"use server";

import {
  type ServerActionsError,
  type ServerActionsResult,
  err,
  ok,
} from "./types";

interface CreateQuoteRepostBody {
  post_id: string;
  text: string;
}

interface CreateQuoteRepostResponse {
  id: string;
  authorId: string;
  parentPostId: {
    UUID: string;
    Valid: boolean;
  };
  text: string;
  type: string;
  createdAt: string;
}

export async function createQuoteRepost(
  userId: string,
  body: CreateQuoteRepostBody,
): Promise<ServerActionsResult<CreateQuoteRepostResponse, ServerActionsError>> {
  const res = await fetch(
    `${process.env.NEXT_PUBLIC_LOCAL_API_BASE_URL}/api/users/${userId}/quote_reposts`,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ post_id: body.post_id, text: body.text }),
    },
  );

  if (res.ok) {
    const data: CreateQuoteRepostResponse = await res.json();
    return ok(data);
  }

  return err({
    status: res.status,
    statusText: res.statusText,
  });
}
