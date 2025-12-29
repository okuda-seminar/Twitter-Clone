import { Test, TestingModule } from "@nestjs/testing";
import type { TimelineItem } from "./models/timeline-item.model";
import { TimelineResolver } from "./timeline.resolver";
import { TimelineService } from "./timeline.service";

describe("TimelineResolver", () => {
  let resolver: TimelineResolver;
  let timelineService: TimelineService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        TimelineResolver,
        {
          provide: TimelineService,
          useValue: {
            getUserPosts: vi.fn(),
            getReverseChronologicalHomeTimeline: vi.fn(),
            createPost: vi.fn(),
            createRepost: vi.fn(),
            deletePost: vi.fn(),
            deleteRepost: vi.fn(),
          },
        },
      ],
    }).compile();

    resolver = module.get<TimelineResolver>(TimelineResolver);
    timelineService = module.get<TimelineService>(TimelineService);
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

    it("should call TimelineService.getReverseChronologicalHomeTimeline and return the result", async () => {
      vi.spyOn(
        timelineService,
        "getReverseChronologicalHomeTimeline",
      ).mockResolvedValue(mockTimelineData as Array<typeof TimelineItem>);

      const result = await resolver.getReverseChronologicalHomeTimeline(userId);

      expect(
        timelineService.getReverseChronologicalHomeTimeline,
      ).toHaveBeenCalledWith(userId);
      expect(result).toEqual(mockTimelineData);
    });

    it("should propagate errors from TimelineService", async () => {
      const serviceError = new Error("Service Error");
      vi.spyOn(
        timelineService,
        "getReverseChronologicalHomeTimeline",
      ).mockRejectedValue(serviceError);

      await expect(
        resolver.getReverseChronologicalHomeTimeline(userId),
      ).rejects.toThrow("Service Error");
      expect(
        timelineService.getReverseChronologicalHomeTimeline,
      ).toHaveBeenCalledWith(userId);
    });

    it("should handle empty timeline data from service", async () => {
      vi.spyOn(
        timelineService,
        "getReverseChronologicalHomeTimeline",
      ).mockResolvedValue([] as Array<typeof TimelineItem>);

      const result = await resolver.getReverseChronologicalHomeTimeline(userId);

      expect(result).toEqual([]);
      expect(result.length).toBe(0);
    });

    it("should call service with correct userId parameter", async () => {
      const specificUserId = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
      vi.spyOn(
        timelineService,
        "getReverseChronologicalHomeTimeline",
      ).mockResolvedValue(mockTimelineData as Array<typeof TimelineItem>);

      await resolver.getReverseChronologicalHomeTimeline(specificUserId);

      expect(
        timelineService.getReverseChronologicalHomeTimeline,
      ).toHaveBeenCalledWith(specificUserId);
      expect(
        timelineService.getReverseChronologicalHomeTimeline,
      ).toHaveBeenCalledTimes(1);
    });
  });

  describe("deletePost", () => {
    const postId = "91c76cd1-29c9-475a-abe3-247234bd9fd4";

    it("should call TimelineService.deletePost and return postId", async () => {
      vi.spyOn(timelineService, "deletePost").mockResolvedValue(postId);

      const result = await resolver.deletePost(postId);

      expect(timelineService.deletePost).toHaveBeenCalledWith(postId);
      expect(result).toBe(postId);
    });
  });

  describe("deleteRepost", () => {
    const userId = "623f9799-e816-418b-9e5e-09ad043653fb";
    const postId = "91c76cd1-29c9-475a-abe3-247234bd9fd4";
    const repostId = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
    const deleteRepostInput = { repost_id: repostId };

    it("should call TimelineService.deleteRepost and return repostId", async () => {
      vi.spyOn(timelineService, "deleteRepost").mockResolvedValue(repostId);

      const result = await resolver.deleteRepost(
        userId,
        postId,
        deleteRepostInput,
      );

      expect(timelineService.deleteRepost).toHaveBeenCalledWith(
        userId,
        postId,
        deleteRepostInput,
      );
      expect(result).toBe(repostId);
    });
  });
});
