import { HttpService } from "@nestjs/axios";
import { INestApplication } from "@nestjs/common";
import { Test, TestingModule } from "@nestjs/testing";
import type { AxiosResponse } from "axios";
import { of, throwError } from "rxjs";
import request from "supertest";
import { AppModule } from "./../src/app.module";

describe("User GraphQL (e2e)", () => {
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

  describe("createUser Mutation", () => {
    const mockAuthenticatedUser = {
      token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
      user: {
        id: "550e8400-e29b-41d4-a716-446655440000",
        username: "testuser",
        displayName: "Test User",
        bio: "",
        isPrivate: false,
        createdAt: "2025-01-01T00:00:00Z",
        updatedAt: "2025-01-01T00:00:00Z",
      },
    };

    it("should create a user successfully", async () => {
      vi.spyOn(httpService, "post").mockReturnValue(
        of({ data: mockAuthenticatedUser } as AxiosResponse),
      );

      const mutation = `
        mutation {
          createUser(createUserInput: {
            username: "testuser"
            display_name: "Test User"
            password: "password123"
          }) {
            token
            user {
              id
              username
              displayName
              bio
              isPrivate
              createdAt
              updatedAt
            }
          }
        }
      `;

      const response = await request(app.getHttpServer())
        .post("/graphql")
        .send({ query: mutation })
        .expect(200);

      expect(response.body.data.createUser).toEqual(mockAuthenticatedUser);
    });

    it("should return an error when the request body is invalid", async () => {
      const badRequestError = {
        response: { status: 400, data: { message: "Bad Request" } },
        message: "Request failed with status code 400",
      };
      vi.spyOn(httpService, "post").mockReturnValue(
        throwError(() => badRequestError),
      );

      const mutation = `
        mutation {
          createUser(createUserInput: {
            username: "testuser"
            display_name: "Test User"
            password: "password123"
          }) {
            token
            user {
              id
            }
          }
        }
      `;

      const response = await request(app.getHttpServer())
        .post("/graphql")
        .send({ query: mutation })
        .expect(200);

      expect(response.body.errors).toBeDefined();
      expect(response.body.errors[0].message).toBeDefined();
    });

    it("should return an error when the username already exists", async () => {
      const conflictError = {
        response: {
          status: 409,
          data: { message: "The specified username has already existed" },
        },
        message: "Request failed with status code 409",
      };
      vi.spyOn(httpService, "post").mockReturnValue(
        throwError(() => conflictError),
      );

      const mutation = `
        mutation {
          createUser(createUserInput: {
            username: "existinguser"
            display_name: "Existing User"
            password: "password123"
          }) {
            token
            user {
              id
            }
          }
        }
      `;

      const response = await request(app.getHttpServer())
        .post("/graphql")
        .send({ query: mutation })
        .expect(200);

      expect(response.body.errors).toBeDefined();
      expect(response.body.errors[0].message).toBeDefined();
    });

    it("should return an error when backend API fails", async () => {
      const httpError = new Error("Internal Server Error");
      vi.spyOn(httpService, "post").mockReturnValue(
        throwError(() => httpError),
      );

      const mutation = `
        mutation {
          createUser(createUserInput: {
            username: "testuser"
            display_name: "Test User"
            password: "password123"
          }) {
            token
            user {
              id
            }
          }
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

    it("should return error when required fields are not provided", async () => {
      const mutation = `
        mutation CreateUser($createUserInput: CreateUserInput!) {
          createUser(createUserInput: $createUserInput) {
            token
            user {
              id
            }
          }
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
        'Variable "$createUserInput" of required type "CreateUserInput!" was not provided',
      );
    });
  });

  describe("deleteUserById Mutation", () => {
    const userId = "550e8400-e29b-41d4-a716-446655440000";

    it("should delete a user successfully", async () => {
      vi.spyOn(httpService, "delete").mockReturnValue(
        of({ status: 204 } as AxiosResponse),
      );

      const mutation = `
        mutation {
          deleteUserById(userId: "${userId}")
        }
      `;

      const response = await request(app.getHttpServer())
        .post("/graphql")
        .send({ query: mutation })
        .expect(200);

      expect(response.body.data.deleteUserById).toBe(userId);
      expect(httpService.delete).toHaveBeenCalledWith(`/api/users/${userId}`);
    });

    it("should return error when user does not exist", async () => {
      const notFoundError = {
        response: {
          status: 404,
          data: { message: "The specified user was not find" },
        },
        message: "Request failed with status code 404",
      };
      vi.spyOn(httpService, "delete").mockReturnValue(
        throwError(() => notFoundError),
      );

      const mutation = `
        mutation {
          deleteUserById(userId: "non-existent-user-id")
        }
      `;

      const response = await request(app.getHttpServer())
        .post("/graphql")
        .send({ query: mutation })
        .expect(200);

      expect(response.body.errors).toBeDefined();
      expect(response.body.errors[0].message).toBeDefined();
    });

    it("should return an error when backend API fails", async () => {
      const httpError = new Error("Internal Server Error");
      vi.spyOn(httpService, "delete").mockReturnValue(
        throwError(() => httpError),
      );

      const mutation = `
        mutation {
          deleteUserById(userId: "${userId}")
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

    it("should return error when userId is not provided", async () => {
      const mutation = `
        mutation DeleteUserById($userId: ID!) {
            deleteUserById(userId: $userId)
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
        'Variable "$userId" of required type "ID!" was not provided',
      );
    });
  });
});
