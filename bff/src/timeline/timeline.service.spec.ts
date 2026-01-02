import { HttpService } from "@nestjs/axios";
import { Test, TestingModule } from "@nestjs/testing";
import type { AxiosResponse } from "axios";
import { of, throwError } from "rxjs";
import { TimelineService } from "./timeline.service";

describe("TimelineService", () => {
  let service: TimelineService;
  let httpService: HttpService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        TimelineService,
        {
          provide: HttpService,
          useValue: {
            get: vi.fn(),
            post: vi.fn(),
            delete: vi.fn(),
          },
        },
      ],
    }).compile();

    service = module.get<TimelineService>(TimelineService);
    httpService = module.get<HttpService>(HttpService);
  });

  describe("getReverseChronologicalHomeTimeline", () => {
    const userId = "623f9799-e816-418b-9e5e-09ad043653fb";
    const mockTimelineData = [
      {
        type: "Post",
        id: "91c76cd1-29c9-475a-abe3-247234bd9fd4",
        authorId: "623f9799-e816-418b-9e5e-09ad043653fb",
        text: "Hello World",
        createdAt: "2025-01-01T00:00:00Z",
      },
      {
        type: "Repost",
        id: "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
        authorId: "b2c3d4e5-f6a7-8901-bcde-f12345678901",
        parentPostId: {
          UUID: "91c76cd1-29c9-475a-abe3-247234bd9fd4",
          Valid: true,
        },
        createdAt: "2025-01-02T00:00:00Z",
      },
      {
        type: "QuoteRepost",
        id: "c3d4e5f6-a7b8-9012-cdef-123456789012",
        authorId: "d4e5f6a7-b8c9-0123-def1-234567890123",
        parentPostId: {
          UUID: "91c76cd1-29c9-475a-abe3-247234bd9fd4",
          Valid: true,
        },
        text: "Great post!",
        createdAt: "2025-01-03T00:00:00Z",
      },
    ];

    it("should fetch timeline data from the backend API successfully", async () => {
      vi.spyOn(httpService, "get").mockReturnValue(
        of({ data: mockTimelineData } as AxiosResponse),
      );

      const result = await service.getReverseChronologicalHomeTimeline(userId);

      expect(httpService.get).toHaveBeenCalledWith(
        `/api/users/${userId}/timelines/reverse_chronological`,
      );
      expect(result).toEqual(mockTimelineData);
    });

    it("should throw an error when the backend API returns an HTTP error", async () => {
      const httpError = new Error("Internal Server Error");
      vi.spyOn(httpService, "get").mockReturnValue(throwError(() => httpError));

      await expect(
        service.getReverseChronologicalHomeTimeline(userId),
      ).rejects.toThrow("Internal Server Error");
    });

    it("should throw an error when the backend API returns a network error", async () => {
      const networkError = new Error("Network Error");
      vi.spyOn(httpService, "get").mockReturnValue(
        throwError(() => networkError),
      );

      await expect(
        service.getReverseChronologicalHomeTimeline(userId),
      ).rejects.toThrow("Network Error");
    });

    it("should handle empty timeline data", async () => {
      const emptyTimeline: never[] = [];
      vi.spyOn(httpService, "get").mockReturnValue(
        of({ data: emptyTimeline } as AxiosResponse),
      );

      const result = await service.getReverseChronologicalHomeTimeline(userId);

      expect(result).toEqual([]);
      expect(result.length).toBe(0);
    });
  });

  describe("deletePost", () => {
    const postId = "91c76cd1-29c9-475a-abe3-247234bd9fd4";

    it("should delete a post successfully", async () => {
      vi.spyOn(httpService, "delete").mockReturnValue(
        of({ status: 204 } as AxiosResponse),
      );

      const result = await service.deletePost(postId);

      expect(httpService.delete).toHaveBeenCalledWith(`/api/posts/${postId}`);
      expect(result).toBe(postId);
    });

    it("should throw an error when the backend API returns an HTTP error", async () => {
      const httpError = new Error("Internal Server Error");
      vi.spyOn(httpService, "delete").mockReturnValue(
        throwError(() => httpError),
      );

      await expect(service.deletePost(postId)).rejects.toThrow(
        "Internal Server Error",
      );
    });

    it("should throw an error when the post does not exist", async () => {
      const notFoundError = new Error("Not Found");
      vi.spyOn(httpService, "delete").mockReturnValue(
        throwError(() => notFoundError),
      );

      await expect(service.deletePost(postId)).rejects.toThrow("Not Found");
    });
  });

  describe("deleteRepost", () => {
    const userId = "623f9799-e816-418b-9e5e-09ad043653fb";
    const postId = "91c76cd1-29c9-475a-abe3-247234bd9fd4";
    const repostId = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
    const deleteRepostInput = { repost_id: repostId };

    it("should delete a repost successfully", async () => {
      vi.spyOn(httpService, "delete").mockReturnValue(
        of({ status: 204 } as AxiosResponse),
      );

      const result = await service.deleteRepost(
        userId,
        postId,
        deleteRepostInput,
      );

      expect(httpService.delete).toHaveBeenCalledWith(
        `/api/users/${userId}/reposts/${postId}`,
        { data: deleteRepostInput },
      );
      expect(result).toBe(repostId);
    });

    it("should throw an error when the backend API returns an HTTP error", async () => {
      const httpError = new Error("Internal Server Error");
      vi.spyOn(httpService, "delete").mockReturnValue(
        throwError(() => httpError),
      );

      await expect(
        service.deleteRepost(userId, postId, deleteRepostInput),
      ).rejects.toThrow("Internal Server Error");
    });

    it("should throw an error when the repost does not exist", async () => {
      const notFoundError = new Error("Not Found");
      vi.spyOn(httpService, "delete").mockReturnValue(
        throwError(() => notFoundError),
      );

      await expect(
        service.deleteRepost(userId, postId, deleteRepostInput),
      ).rejects.toThrow("Not Found");
    });
  });

  describe("likePost", () => {
    const userId = "623f9799-e816-418b-9e5e-09ad043653fb";
    const likePostInput = {
      post_id: "91c76cd1-29c9-475a-abe3-247234bd9fd4",
    };

    it("should like a post successfully", async () => {
      vi.spyOn(httpService, "post").mockReturnValue(
        of({ status: 204 } as AxiosResponse),
      );

      const result = await service.likePost(userId, likePostInput);

      expect(httpService.post).toHaveBeenCalledWith(
        `/api/users/${userId}/likes`,
        likePostInput,
      );
      expect(result).toBe(likePostInput.post_id);
    });

    it("should throw an error when the backend API fails", async () => {
      const httpError = new Error("Internal Server Error");
      vi.spyOn(httpService, "post").mockReturnValue(
        throwError(() => httpError),
      );

      await expect(service.likePost(userId, likePostInput)).rejects.toThrow(
        "Internal Server Error",
      );
    });
  });

  describe("unlikePost", () => {
    const userId = "623f9799-e816-418b-9e5e-09ad043653fb";
    const postId = "91c76cd1-29c9-475a-abe3-247234bd9fd4";

    it("should unlike a post successfully", async () => {
      vi.spyOn(httpService, "delete").mockReturnValue(
        of({ status: 204 } as AxiosResponse),
      );

      const result = await service.unlikePost(userId, postId);

      expect(httpService.delete).toHaveBeenCalledWith(
        `/api/users/${userId}/likes/${postId}`,
      );
      expect(result).toBe(postId);
    });

    it("should throw an error when the backend API fails", async () => {
      const httpError = new Error("Internal Server Error");
      vi.spyOn(httpService, "delete").mockReturnValue(
        throwError(() => httpError),
      );

      await expect(service.unlikePost(userId, postId)).rejects.toThrow(
        "Internal Server Error",
      );
    });
  });
});
