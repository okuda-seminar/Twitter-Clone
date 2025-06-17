import { AUTH_COOKIE_OPTIONS } from "@/lib/constants/cookie-constants";
import { type NextRequest, NextResponse } from "next/server";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { middleware } from "../middleware";
// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/769
// - Add E2E tests for actual access control behavior.
vi.mock("next/server", () => ({
  NextRequest: vi.fn(),
  NextResponse: {
    next: vi.fn(() => ({ type: "next" })),
    redirect: vi.fn((url: URL) => ({ type: "redirect", url: url.toString() })),
  },
}));

describe("middleware", () => {
  const BASE_URL = process.env.VITE_FRONTEND_URL;

  beforeEach(() => {
    vi.clearAllMocks();
  });

  const createMockRequest = (pathname: string, authToken?: string) => {
    const url = new URL(pathname, BASE_URL);
    const mockRequest = {
      nextUrl: url,
      url: url.toString(),
      cookies: {
        get: (name: string) => {
          if (name === AUTH_COOKIE_OPTIONS.name && authToken) {
            return { name, value: authToken };
          }
          return undefined;
        },
      },
    } as NextRequest;
    return mockRequest;
  };

  describe("Rule 1: Unauthenticated user accessing protected route → Redirect to login", () => {
    it("should redirect unauthenticated users from protected routes", () => {
      const request = createMockRequest("/home");
      const response = middleware(request);

      expect(response.type).toBe("redirect");
      expect(response.url).toBe(`${BASE_URL}/login`);
    });
  });

  describe("Rule 2: Authenticated user accessing public route → Redirect to home", () => {
    it("should redirect authenticated users from login page", () => {
      const request = createMockRequest("/login", "any-token");
      const response = middleware(request);

      expect(response.type).toBe("redirect");
      expect(response.url).toBe(`${BASE_URL}/home`);
    });

    it("should redirect authenticated users from signup page", () => {
      const request = createMockRequest("/signup", "any-token");
      const response = middleware(request);

      expect(response.type).toBe("redirect");
      expect(response.url).toBe(`${BASE_URL}/home`);
    });
  });

  describe("Rule 3: All other cases → Continue to the requested page", () => {
    it("should allow unauthenticated access to public routes", () => {
      const request = createMockRequest("/login");
      const response = middleware(request);

      expect(response).toEqual({ type: "next" });
      expect(NextResponse.redirect).not.toHaveBeenCalled();
    });

    it("should allow authenticated access to protected routes", () => {
      const request = createMockRequest("/home", "any-token");
      const response = middleware(request);

      expect(response).toEqual({ type: "next" });
      expect(NextResponse.redirect).not.toHaveBeenCalled();
    });
  });
});
