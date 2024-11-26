"use server";

import { err, ok, ServerActionsError, ServerActionsResult } from "./types";

interface FindUserByIdBody {
  user_id: string;
}

export interface FindUserByIdResponse {
  id: string;
  username: string;
  display_name: string;
  bio: string;
  is_private: boolean;
  created_at: string;
  updated_at: string;
}

export async function findUserById({
  user_id,
}: FindUserByIdBody): Promise<
  ServerActionsResult<FindUserByIdResponse, ServerActionsError>
> {
  const res = await fetch(`${process.env.API_BASE_URL}/api/users/${user_id}`, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  });

  if (res.ok) {
    const data: FindUserByIdResponse = await res.json();
    return ok(data);
  } else {
    return err({
      status: res.status,
      statusText: res.statusText,
    });
  }
}
