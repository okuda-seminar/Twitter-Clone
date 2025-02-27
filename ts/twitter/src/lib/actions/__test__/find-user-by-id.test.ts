import { STATUS_TEXT } from "@/lib/constants/error-messages";
import { findUserById } from "../find-user-by-id";

describe("findUserById Tests", () => {
  const buildEndpoint = (user_id: string) => {
    return `${process.env.API_BASE_URL}/api/users/${user_id}`;
  };
  const mockFetch = jest.fn();
  global.fetch = mockFetch;

  describe("Success cases", () => {
    test("User data should be returned when finding a user by ID succeeds", async () => {
      // Arrange
      const user_id = "123";
      const endpoint = buildEndpoint(user_id);
      const mockResponse = {
        id: "123",
        username: "test",
        display_name: "test",
        bio: "test",
        is_private: false,
        created_at: "2024-01-01",
        updated_at: "2024-01-01",
      };
      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => mockResponse,
      });

      // Act
      const result = await findUserById({
        user_id,
      });

      // Assert
      expect(result).toEqual({ ok: true, value: mockResponse });
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
    test("HTTP error should be handled appropriately", async () => {
      // Arrange
      mockFetch.mockResolvedValueOnce({
        ok: false,
        status: 500,
        statusText: STATUS_TEXT.INTERNAL_SERVER_ERROR,
      });

      // Act
      const result = await findUserById({ user_id: "non-existent" });

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
        findUserById({
          user_id: "test-user",
        }),
      ).rejects.toThrow();
    });
  });
});
