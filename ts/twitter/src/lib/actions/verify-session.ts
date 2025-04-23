"use server";

import type { User } from "@/lib/models/user";
import { cookies } from "next/headers";
import { ERROR_MESSAGES } from "../constants/error-messages";
import { HTTP_STATUS } from "../constants/http-status";
import {
  type ServerActionsError,
  type ServerActionsResult,
  err,
  ok,
} from "./types";

type VerifySessionResponse = User;

export async function verifySession(): Promise<
  ServerActionsResult<VerifySessionResponse, ServerActionsError>
> {
  const cookieStore = await cookies();
  const authToken = cookieStore.get("auth_token");

  if (!authToken || !authToken.value) {
    return err({
      status: HTTP_STATUS.UNAUTHORIZED,
      statusText: ERROR_MESSAGES.NO_AUTH_TOKEN,
    });
  }

  const res = await fetch(
    `${process.env.NEXT_PUBLIC_LOCAL_API_BASE_URL}/api/session/verify`,
    {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authToken.value}`,
      },
    },
  );

  if (res.ok) {
    const user: VerifySessionResponse = await res.json();
    return ok(user);
  }

  return err({
    status: res.status,
    statusText: res.statusText,
  });
}
