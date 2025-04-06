"use server";

import type { User } from "@/lib/models/user";
import {
  type ServerActionsError,
  type ServerActionsResult,
  err,
  ok,
} from "./types";

export interface SignupBody {
  displayName: string;
  username: string;
  password: string;
}

interface SignupResponse {
  token: string;
  user: User;
}

export async function signup(
  body: SignupBody,
): Promise<ServerActionsResult<SignupResponse, ServerActionsError>> {
  const res = await fetch(
    `${process.env.NEXT_PUBLIC_LOCAL_API_BASE_URL}/api/users`,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        display_name: body.displayName,
        username: body.username,
        password: body.password,
      }),
    },
  );

  if (res.ok) {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/631
    // - Store the JWT in a cookie.
    const data: SignupResponse = await res.json();
    return ok(data);
  }

  return err({
    status: res.status,
    statusText: res.statusText,
  });
}
