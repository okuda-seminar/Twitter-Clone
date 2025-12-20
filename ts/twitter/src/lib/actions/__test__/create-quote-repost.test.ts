import { STATUS_TEXT } from "@/lib/constants/error-messages";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { createQuoteRepost } from "../create-quote-repost";
import type { CreateQuoteRepostResponse } from "../create-quote-repost";

const mockFetch = vi.fn();
vi.stubGlobal("fetch", mockFetch);

describe("createQuoteRepost API Tests", () => {
  const mockUserId = "test-user-id";
  const mockPostId = "test-post-id";
  const mockText = "This is my comment on the post";
  const mockResponse: CreateQuoteRepostResponse = {
    id: "quote-repost-id",
    authorId: mockUserId,
    parentPostId: { UUID: mockPostId, Valid: true },
    text: mockText,
    type: "quoteRepost",
    createdAt: "2024-01-01T00:00:00Z",
  };

  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe("Successful requests", () => {
    it("should return the created quote repost when the request succeeds", async () => {
      // Arrange
      const API_ENDPOINT = `${process.env.NEXT_PUBLIC_LOCAL_API_BASE_URL}/api/users/${mockUserId}/quote_reposts`;

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => mockResponse,
      });

      // Act
      const result = await createQuoteRepost(mockUserId, {
        post_id: mockPostId,
        text: mockText,
      });

      // Assert
      expect(result.ok).toBe(true);
      if (result.ok) {
        expect(result.value).toEqual(mockResponse);
      }

      expect(mockFetch).toHaveBeenCalledWith(
        API_ENDPOINT,
        expect.objectContaining({
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            post_id: mockPostId,
            text: mockText,
          }),
        }),
      );
    });

    it("should handle empty text", async () => {
      // Arrange
      const emptyTextResponse = {
        ...mockResponse,
        text: "",
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => emptyTextResponse,
      });

      // Act
      const result = await createQuoteRepost(mockUserId, {
        post_id: mockPostId,
        text: "",
      });

      // Assert
      expect(result.ok).toBe(true);
      if (result.ok) {
        expect(result.value.text).toBe("");
      }
    });

    it("should handle long text (280 characters)", async () => {
      // Arrange
      const longText = "a".repeat(280);
      const longTextResponse = {
        ...mockResponse,
        text: longText,
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => longTextResponse,
      });

      // Act
      const result = await createQuoteRepost(mockUserId, {
        post_id: mockPostId,
        text: longText,
      });

      // Assert
      expect(result.ok).toBe(true);
      if (result.ok) {
        expect(result.value.text).toBe(longText);
        expect(result.value.text.length).toBe(280);
      }
    });
  });

  describe("Failed requests", () => {
    it("should return an error when the API responds with 500", async () => {
      // Arrange
      mockFetch.mockResolvedValueOnce({
        ok: false,
        status: 500,
        statusText: STATUS_TEXT.INTERNAL_SERVER_ERROR,
      });

      // Act
      const result = await createQuoteRepost(mockUserId, {
        post_id: mockPostId,
        text: mockText,
      });

      // Assert
      expect(result.ok).toBe(false);
      if (!result.ok) {
        expect(result.error.status).toBe(500);
        expect(result.error.statusText).toBe(STATUS_TEXT.INTERNAL_SERVER_ERROR);
      }
    });

    it("should return an error when the API responds with 400", async () => {
      // Arrange
      mockFetch.mockResolvedValueOnce({
        ok: false,
        status: 400,
        statusText: "Bad Request",
      });

      // Act
      const result = await createQuoteRepost(mockUserId, {
        post_id: mockPostId,
        text: mockText,
      });

      // Assert
      expect(result.ok).toBe(false);
      if (!result.ok) {
        expect(result.error.status).toBe(400);
        expect(result.error.statusText).toBe("Bad Request");
      }
    });

    it("should throw an error when network fails", async () => {
      // Arrange
      mockFetch.mockRejectedValueOnce(new Error("Network error"));

      // Act & Assert
      await expect(
        createQuoteRepost(mockUserId, {
          post_id: mockPostId,
          text: mockText,
        }),
      ).rejects.toThrow("Network error");
    });

    it("should throw an error when the request cannot be sent due to unexpected reasons", async () => {
      // Arrange
      mockFetch.mockRejectedValueOnce(new Error("Unexpected error"));

      // Act & Assert
      await expect(
        createQuoteRepost(mockUserId, {
          post_id: mockPostId,
          text: mockText,
        }),
      ).rejects.toThrow("Unexpected error");
    });
  });

  describe("Edge cases", () => {
    it("should handle quote repost with special characters", async () => {
      // Arrange
      const specialText = "Hello! 🎉 @user #hashtag https://example.com";
      const specialTextResponse = {
        ...mockResponse,
        text: specialText,
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => specialTextResponse,
      });

      // Act
      const result = await createQuoteRepost(mockUserId, {
        post_id: mockPostId,
        text: specialText,
      });

      // Assert
      expect(result.ok).toBe(true);
      if (result.ok) {
        expect(result.value.text).toBe(specialText);
      }
    });

    it("should handle quote repost with newlines", async () => {
      // Arrange
      const multilineText = "Line 1\nLine 2\nLine 3";
      const multilineResponse = {
        ...mockResponse,
        text: multilineText,
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => multilineResponse,
      });

      // Act
      const result = await createQuoteRepost(mockUserId, {
        post_id: mockPostId,
        text: multilineText,
      });

      // Assert
      expect(result.ok).toBe(true);
      if (result.ok) {
        expect(result.value.text).toBe(multilineText);
      }
    });

    it("should handle invalid parent post ID format", async () => {
      // Arrange
      const invalidResponse = {
        ...mockResponse,
        parentPostId: { UUID: "", Valid: false },
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => invalidResponse,
      });

      // Act
      const result = await createQuoteRepost(mockUserId, {
        post_id: "",
        text: mockText,
      });

      // Assert
      expect(result.ok).toBe(true);
      if (result.ok) {
        expect(result.value.parentPostId.Valid).toBe(false);
      }
    });
  });
});
