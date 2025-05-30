"use server";

import { AUTH_COOKIE_OPTIONS } from "@/lib/constants/cookie-constants";
import { cookies } from "next/headers";
import { redirect } from "next/navigation";

export async function logout(): Promise<void> {
  const cookieStore = await cookies();
  cookieStore.delete(AUTH_COOKIE_OPTIONS.name);
  redirect("/login");
}
