"use server";

import { AUTH_COOKIE_OPTIONS } from "@/lib/constants/cookie-constants";
import type { User } from "@/lib/models/user";
import { cookies } from "next/headers";
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
    const data: LoginResponse = await res.json();
    cookies().set({
      ...AUTH_COOKIE_OPTIONS,
      value: data.token,
    });

    return ok(data);
  }

  return err({
    status: res.status,
    statusText: res.statusText,
  });
}
