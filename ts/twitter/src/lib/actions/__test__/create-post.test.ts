import { STATUS_TEXT } from "@/lib/constants/error-messages";
import { createPost } from "../create-post";

describe("createPost API Tests", () => {
  const API_ENDPOINT = `${process.env.API_BASE_URL}/api/posts`;
  const mockFetch = vi.fn();
  vi.stubGlobal("fetch", mockFetch);

  const request = {
    user_id: "623f9799-e816-418b-9e5e-09ad043653fb",
    text: "test post",
  };

  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe("Successful requests", () => {
    it("should return the created post when the request succeeds", async () => {
      // Arrange
      const response = {
        id: "91c76cd1-29c9-475a-abe3-247234bd9fd4",
        user_id: request.user_id,
        text: request.text,
        created_at: "2024-01-01T00:00:00Z",
      };

      mockFetch.mockResolvedValueOnce({
        ok: true,
        json: async () => response,
      });

      // Act
      const result = await createPost(request);

      // Assert
      expect(result).toEqual({ ok: true, value: response });
      expect(mockFetch).toHaveBeenCalledWith(
        API_ENDPOINT,
        expect.objectContaining({
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(request),
        }),
      );
    });
  });

  describe("Failed requests", () => {
    it("should return an error when the API responds with an error", async () => {
      // Arrange
      const response = {
        ok: false,
        status: 500,
        statusText: STATUS_TEXT.INTERNAL_SERVER_ERROR,
      };

      mockFetch.mockResolvedValueOnce(response);

      // Act
      const result = await createPost(request);

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
      await expect(createPost(request)).rejects.toThrow(errorMessage);
    });
  });
});
