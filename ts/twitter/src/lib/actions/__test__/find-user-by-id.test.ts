import { STATUS_TEXT } from "@/lib/constants/error-messages";
import { findUserById } from "../find-user-by-id";

describe("findUserById API Tests", () => {
  const mockFetch = vi.fn();
  vi.stubGlobal("fetch", mockFetch);

  const request = {
    user_id: "623f9799-e816-418b-9e5e-09ad043653fb",
  };

  const API_ENDPOINT = `${process.env.NEXT_PUBLIC_LOCAL_API_BASE_URL}/api/users/${request.user_id}`;

  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe("Successful requests", () => {
    it("should return user data when a user is successfully found by ID", async () => {
      // Arrange
      const response = {
        id: request.user_id,
        username: "test",
        display_name: "test",
        bio: "test",
        is_private: false,
        created_at: "2024-01-01T00:00:00Z",
        updated_at: "2024-01-01T00:00:00Z",
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => response,
      });

      // Act
      const result = await findUserById(request);

      // Assert
      expect(result).toEqual({ ok: true, value: response });
      expect(mockFetch).toHaveBeenCalledWith(
        API_ENDPOINT,
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
    it("should return an error when the API responds with an error", async () => {
      // Arrange
      const response = {
        ok: false,
        status: 500,
        statusText: STATUS_TEXT.INTERNAL_SERVER_ERROR,
      };

      mockFetch.mockResolvedValueOnce(response);

      // Act
      const result = await findUserById(request);

      // Assert
      expect(result).toEqual({
        ok: false,
        error: {
          status: response.status,
          statusText: response.statusText,
        },
      });
    });

    it("should throw an error when the request cannot be sent due to unexpected reasons", async () => {
      // Arrange
      const errorMessage = "Network error";
      mockFetch.mockRejectedValueOnce(new Error(errorMessage));

      // Act & Assert
      await expect(findUserById(request)).rejects.toThrow(errorMessage);
    });
  });
});
