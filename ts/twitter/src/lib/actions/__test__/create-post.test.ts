import { STATUS_TEXT } from "@/lib/constants/error-messages";
import { createPost } from "../create-post";

describe("createPost Tests", () => {
  const endpoint = `${process.env.API_BASE_URL}/api/posts`;
  const mockFetch = jest.fn();
  global.fetch = mockFetch;

  describe("Success cases", () => {
    test("Post data should be returned when post creation succeeds", async () => {
      // Arrange
      const mockResponse = {
        id: "123",
        user_id: "test-user",
        text: "test post",
        created_at: "2024-01-01T00:00:00Z",
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => mockResponse,
      });

      // Act
      const result = await createPost({
        user_id: "test-user",
        text: "test post",
      });

      // Assert
      expect(result).toEqual({ ok: true, value: mockResponse });
      expect(mockFetch).toHaveBeenCalledWith(
        endpoint,
        expect.objectContaining({
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            user_id: "test-user",
            text: "test post",
          }),
        }),
      );
    });
  });

  describe("Error cases", () => {
    test("HTTP error should be handled appropriately", async () => {
      // Arrange
      mockFetch.mockResolvedValueOnce({
        ok: false,
        status: 500,
        statusText: STATUS_TEXT.INTERNAL_SERVER_ERROR,
      });

      // Act
      const result = await createPost({
        user_id: "test-user",
        text: "test post",
      });

      // Assert
      expect(result).toEqual({
        ok: false,
        error: {
          status: 500,
          statusText: STATUS_TEXT.INTERNAL_SERVER_ERROR,
        },
      });
    });

    test("The case where the client cannot send a request should be handled", async () => {
      // Act & Assert
      await expect(
        createPost({
          user_id: "test-user",
          text: "test post",
        }),
      ).rejects.toThrow();
    });
  });
});
