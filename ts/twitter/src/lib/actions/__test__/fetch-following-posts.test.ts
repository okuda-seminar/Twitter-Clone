import {
  type FollowingPostsResponse,
  fetchFollowingPosts,
} from "../fetch-following-posts";

describe("fetch following posts Tests", () => {
  const buildEndpoint = (user_id: string) => {
    return `${process.env.API_BASE_URL}/api/users/${user_id}/timelines/reverse_chronological`;
  };
  const mockFetch = jest.fn();
  global.fetch = mockFetch;

  describe("Success cases", () => {
    test("Posts data should be returned when getting a collection of posts succeeds", async () => {
      // Arrange
      const user_id = "123";
      const endpoint = buildEndpoint(user_id);
      const mockResponse: FollowingPostsResponse = [
        {
          id: "123",
          user_id: "456",
          text: "test text",
          created_at: "2024-01-01",
        },
      ];
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => mockResponse,
      });

      // Act
      const result = await fetchFollowingPosts({
        user_id,
      });

      // Assert
      expect(result).toEqual(mockResponse);
      expect(mockFetch).toHaveBeenCalledWith(
        endpoint,
        expect.objectContaining({
          method: "GET",
          headers: {
            "Content-Type": "application/json",
          },
        }),
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
        fetchFollowingPosts({
          user_id: "non-existent",
        }),
      ).rejects.toThrow("Unable to find post. Please try again later.");
    });

    test("The case where the client cannot send a request should be handled", async () => {
      // Act & Assert
      await expect(
        fetchFollowingPosts({
          user_id: "test-user",
        }),
      ).rejects.toThrow();
    });
  });
});
