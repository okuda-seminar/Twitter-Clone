import { AUTH_COOKIE_OPTIONS } from "@/lib/constants/cookie-constants";
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

const PUBLIC_ROUTES = {
  login: "/login",
  signup: "/signup",
};

const HOME_ROUTE = "/home";

export function middleware(request: NextRequest) {
  const pathname = request.nextUrl.pathname;
  const authToken = request.cookies.get(AUTH_COOKIE_OPTIONS.name)?.value;

  const isPublicRoute = Object.values(PUBLIC_ROUTES).some(
    (route) => pathname === route,
  );

  const hasAuthToken = !!authToken;

  // Rule 1: Unauthenticated user accessing protected route → Redirect to login.
  if (!hasAuthToken && !isPublicRoute) {
    const loginUrl = new URL(PUBLIC_ROUTES.login, request.url);
    return NextResponse.redirect(loginUrl);
  }

  // Rule 2: Authenticated user accessing public route → Redirect to home.
  if (hasAuthToken && isPublicRoute) {
    const homeUrl = new URL(HOME_ROUTE, request.url);
    return NextResponse.redirect(homeUrl);
  }

  // Rule 3: All other cases → Continue to the requested page.
  return NextResponse.next();
}

export const config = {
  matcher: ["/((?!api|_next/static|_next/image|favicon.ico|robots.txt).*)"],
};
