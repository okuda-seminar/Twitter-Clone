"use server";

import type { User } from "@/lib/models/user";
import {
  type ServerActionsError,
  type ServerActionsResult,
  err,
  ok,
} from "./types";

export interface LoginBody {
  username: string;
  password: string;
}

interface LoginResponse {
  token: string;
  user: User;
}

export async function login(
  body: LoginBody,
): Promise<ServerActionsResult<LoginResponse, ServerActionsError>> {
  const res = await fetch(
    `${process.env.NEXT_PUBLIC_LOCAL_API_BASE_URL}/api/login`,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body),
    },
  );

  if (res.ok) {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/631
    // - Store the JWT in a cookie.
    const apiData = await res.json();
    const { user: apiUser, token } = apiData;

    const user: User = {
      id: apiUser.id,
      username: apiUser.username,
      displayName: apiUser.display_name,
      bio: apiUser.bio,
      isPrivate: apiUser.is_private,
      createdAt: apiUser.created_at,
      updatedAt: apiUser.updated_at,
    };

    return ok({ token, user });
  }

  return err({
    status: res.status,
    statusText: res.statusText,
  });
}
