import { createPost } from "../create-post";

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/488 - Fix Jest Recognition in Local Development Environment.

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
      expect(result).toEqual(mockResponse);
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
        })
      );
    });
  });

  describe("Error cases", () => {
    test("http error should be handled appropriately", async () => {
      // Arrange
      mockFetch.mockResolvedValueOnce({
        ok: false,
      });

      // Act & Assert
      await expect(
        createPost({
          user_id: "test-user",
          text: "test post",
        })
        // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/489 - Centralize Error Messages Management.
      ).rejects.toThrow("Unable to create post. Please try again later.");
    });

    test("The case where the client cannot send a request should be handled", async () => {
      // Act & Assert
      await expect(
        createPost({
          user_id: "test-user",
          text: "test post",
        })
      ).rejects.toThrow();
    });
  });
});
