import { HttpService } from "@nestjs/axios";
import { INestApplication } from "@nestjs/common";
import { Test, TestingModule } from "@nestjs/testing";
import type { AxiosResponse } from "axios";
import { of, throwError } from "rxjs";
import request from "supertest";
import { AppModule } from "./../src/app.module";

describe("Timeline GraphQL (e2e)", () => {
  let app: INestApplication;
  let httpService: HttpService;

  beforeEach(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    await app.init();

    httpService = moduleFixture.get<HttpService>(HttpService);

    vi.clearAllMocks();
  });

  afterEach(async () => {
    await app.close();
  });

  describe("getReverseChronologicalHomeTimeline Query", () => {
    const userId = "623f9799-e816-418b-9e5e-09ad043653fb";
    const mockTimelineData = [
      {
        type: "post",
        id: "91c76cd1-29c9-475a-abe3-247234bd9fd4",
        authorId: "623f9799-e816-418b-9e5e-09ad043653fb",
        text: "Hello World",
        createdAt: "2025-01-01T00:00:00Z",
      },
      {
        type: "repost",
        id: "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
        authorId: "b2c3d4e5-f6a7-8901-bcde-f12345678901",
        parentPostId: {
          UUID: "91c76cd1-29c9-475a-abe3-247234bd9fd4",
          Valid: true,
        },
        createdAt: "2025-01-02T00:00:00Z",
      },
      {
        type: "quoteRepost",
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

    const query = `
      query GetReverseChronologicalHomeTimeline($userId: ID!) {
        getReverseChronologicalHomeTimeline(userId: $userId) {
          ... on Post {
            type
            id
            authorId
            text
            createdAt
          }
          ... on Repost {
            type
            id
            authorId
            parentPostId {
              UUID
              Valid
            }
            createdAt
          }
          ... on QuoteRepost {
            type
            id
            authorId
            parentPostId {
              UUID
              Valid
            }
            text
            createdAt
          }
        }
      }
    `;

    it("should fetch timeline data successfully via GraphQL", () => {
      vi.spyOn(httpService, "get").mockReturnValue(
        of({ data: mockTimelineData } as AxiosResponse),
      );

      return request(app.getHttpServer())
        .post("/graphql")
        .send({
          query,
          variables: { userId },
        })
        .expect(200)
        .expect((res) => {
          expect(res.body.data).toBeDefined();
          expect(
            res.body.data.getReverseChronologicalHomeTimeline,
          ).toBeDefined();
          expect(
            Array.isArray(res.body.data.getReverseChronologicalHomeTimeline),
          ).toBe(true);
          expect(res.body.data.getReverseChronologicalHomeTimeline.length).toBe(
            3,
          );

          const post = res.body.data.getReverseChronologicalHomeTimeline[0];
          expect(post.type).toBe("post");
          expect(post.id).toBe("91c76cd1-29c9-475a-abe3-247234bd9fd4");
          expect(post.authorId).toBe("623f9799-e816-418b-9e5e-09ad043653fb");
          expect(post.text).toBe("Hello World");
          expect(post.createdAt).toBe("2025-01-01T00:00:00Z");

          const repost = res.body.data.getReverseChronologicalHomeTimeline[1];
          expect(repost.type).toBe("repost");
          expect(repost.parentPostId).toBeDefined();
          expect(repost.parentPostId.UUID).toBe(
            "91c76cd1-29c9-475a-abe3-247234bd9fd4",
          );
          expect(repost.parentPostId.Valid).toBe(true);

          const quoteRepost =
            res.body.data.getReverseChronologicalHomeTimeline[2];
          expect(quoteRepost.type).toBe("quoteRepost");
          expect(quoteRepost.text).toBe("Great post!");
        });
    });

    it("should return an empty array when timeline is empty", () => {
      vi.spyOn(httpService, "get").mockReturnValue(
        of({ data: [] } as AxiosResponse),
      );

      return request(app.getHttpServer())
        .post("/graphql")
        .send({
          query,
          variables: { userId },
        })
        .expect(200)
        .expect((res) => {
          expect(res.body.data).toBeDefined();
          expect(
            res.body.data.getReverseChronologicalHomeTimeline,
          ).toBeDefined();
          expect(
            Array.isArray(res.body.data.getReverseChronologicalHomeTimeline),
          ).toBe(true);
          expect(res.body.data.getReverseChronologicalHomeTimeline.length).toBe(
            0,
          );
        });
    });

    it("should return GraphQL error when backend API fails", () => {
      vi.spyOn(httpService, "get").mockReturnValue(
        throwError(() => new Error("Backend API Error")),
      );

      return request(app.getHttpServer())
        .post("/graphql")
        .send({
          query,
          variables: { userId },
        })
        .expect(200)
        .expect((res) => {
          expect(res.body.errors).toBeDefined();
          expect(res.body.errors.length).toBeGreaterThan(0);
          expect(res.body.errors[0].message).toContain("Backend API Error");
        });
    });

    it("should handle different userId values correctly", () => {
      const differentUserId = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
      vi.spyOn(httpService, "get").mockReturnValue(
        of({ data: mockTimelineData } as AxiosResponse),
      );

      return request(app.getHttpServer())
        .post("/graphql")
        .send({
          query,
          variables: { userId: differentUserId },
        })
        .expect(200)
        .expect((res) => {
          expect(res.body.data).toBeDefined();
          expect(httpService.get).toHaveBeenCalledWith(
            `/api/users/${differentUserId}/timelines/reverse_chronological`,
          );
        });
    });

    it("should return error when userId is missing", () => {
      return request(app.getHttpServer())
        .post("/graphql")
        .send({
          query,
          variables: {},
        })
        .expect(200)
        .expect((res) => {
          expect(res.body.errors).toBeDefined();
          expect(res.body.errors.length).toBeGreaterThan(0);
          expect(res.body.errors[0].message).toContain(
            'Variable "$userId" of required type "ID!" was not provided',
          );
        });
    });
  });

  describe("deletePost Mutation", () => {
    const postId = "91c76cd1-29c9-475a-abe3-247234bd9fd4";

    it("should delete a post successfully", async () => {
      vi.spyOn(httpService, "delete").mockReturnValue(
        of({ status: 204 } as AxiosResponse),
      );

      const mutation = `
        mutation {
          deletePost(postId: "${postId}")
        }
      `;

      const response = await request(app.getHttpServer())
        .post("/graphql")
        .send({ query: mutation })
        .expect(200);

      expect(response.body.data.deletePost).toBe(postId);
      expect(httpService.delete).toHaveBeenCalledWith(`/api/posts/${postId}`);
    });

    it("should return an error when backend API fails", async () => {
      const httpError = new Error("Internal Server Error");
      vi.spyOn(httpService, "delete").mockReturnValue(
        throwError(() => httpError),
      );

      const mutation = `
        mutation {
          deletePost(postId: "${postId}")
        }
      `;

      const response = await request(app.getHttpServer())
        .post("/graphql")
        .send({ query: mutation })
        .expect(200);

      expect(response.body.errors).toBeDefined();
      expect(response.body.errors[0].message).toContain(
        "Internal Server Error",
      );
    });

    it("should return error when postId is not provided", async () => {
      const mutation = `
        mutation DeletePost($postId: ID!) {
          deletePost(postId: $postId)
        }
      `;

      const response = await request(app.getHttpServer())
        .post("/graphql")
        .send({
          query: mutation,
          variables: {},
        })
        .expect(200);

      expect(response.body.errors).toBeDefined();
      expect(response.body.errors.length).toBeGreaterThan(0);
      expect(response.body.errors[0].message).toContain(
        'Variable "$postId" of required type "ID!" was not provided',
      );
    });
  });

  describe("deleteRepost Mutation", () => {
    const userId = "623f9799-e816-418b-9e5e-09ad043653fb";
    const postId = "91c76cd1-29c9-475a-abe3-247234bd9fd4";
    const repostId = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";

    it("should delete a repost successfully", async () => {
      vi.spyOn(httpService, "delete").mockReturnValue(
        of({ status: 204 } as AxiosResponse),
      );

      const mutation = `
        mutation {
          deleteRepost(
            userId: "${userId}",
            postId: "${postId}",
            deleteRepostInput: { repost_id: "${repostId}" }
          )
        }
      `;

      const response = await request(app.getHttpServer())
        .post("/graphql")
        .send({ query: mutation })
        .expect(200);

      expect(response.body.data.deleteRepost).toBe(repostId);
      expect(httpService.delete).toHaveBeenCalledWith(
        `/api/users/${userId}/reposts/${postId}`,
        { data: { repost_id: repostId } },
      );
    });

    it("should return an error when backend API fails", async () => {
      const httpError = new Error("Internal Server Error");
      vi.spyOn(httpService, "delete").mockReturnValue(
        throwError(() => httpError),
      );

      const mutation = `
        mutation {
          deleteRepost(
            userId: "${userId}",
            postId: "${postId}",
            deleteRepostInput: { repost_id: "${repostId}" }
          )
        }
      `;

      const response = await request(app.getHttpServer())
        .post("/graphql")
        .send({ query: mutation })
        .expect(200);

      expect(response.body.errors).toBeDefined();
      expect(response.body.errors[0].message).toContain(
        "Internal Server Error",
      );
    });

    it("should return error when required parameters are not provided", async () => {
      const mutation = `
        mutation DeleteRepost($userId: ID!, $postId: ID!, $deleteRepostInput: DeleteRepostInput!) {
          deleteRepost(userId: $userId, postId: $postId, deleteRepostInput: $deleteRepostInput)
        }
      `;

      const response = await request(app.getHttpServer())
        .post("/graphql")
        .send({
          query: mutation,
          variables: {},
        })
        .expect(200);

      expect(response.body.errors).toBeDefined();
      expect(response.body.errors.length).toBeGreaterThan(0);
    });

    it("should return error when repost does not exist", async () => {
      const notFoundError = new Error("Not Found");
      vi.spyOn(httpService, "delete").mockReturnValue(
        throwError(() => notFoundError),
      );

      const mutation = `
        mutation {
          deleteRepost(
            userId: "${userId}",
            postId: "${postId}",
            deleteRepostInput: { repost_id: "${repostId}" }
          )
        }
      `;

      const response = await request(app.getHttpServer())
        .post("/graphql")
        .send({ query: mutation })
        .expect(200);

      expect(response.body.errors).toBeDefined();
      expect(response.body.errors[0].message).toContain("Not Found");
    });
  });
});
