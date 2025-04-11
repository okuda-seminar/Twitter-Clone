export const AUTH_COOKIE_OPTIONS = {
  name: "auth_token",
  httpOnly: true,
  // Set it to false in the development environment.
  secure: process.env.NODE_ENV === "production",
  maxAge: 60 * 60,
  path: "/",
  sameSite: "lax",
} as const;
