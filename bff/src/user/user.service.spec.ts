import { HttpService } from "@nestjs/axios";
import { Test, TestingModule } from "@nestjs/testing";
import type { AxiosResponse } from "axios";
import { of, throwError } from "rxjs";
import { UserService } from "./user.service";

describe("UserService", () => {
  let service: UserService;
  let httpService: HttpService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        UserService,
        {
          provide: HttpService,
          useValue: {
            post: vi.fn(),
            delete: vi.fn(),
          },
        },
      ],
    }).compile();

    service = module.get<UserService>(UserService);
    httpService = module.get<HttpService>(HttpService);
  });

  describe("createUser", () => {
    const createUserInput = {
      username: "testuser",
      display_name: "Test User",
      password: "password123",
    };

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

      const result = await service.createUser(createUserInput);

      expect(httpService.post).toHaveBeenCalledWith(
        "/api/users",
        createUserInput,
      );
      expect(result).toEqual(mockAuthenticatedUser);
    });

    it("should throw an error when the request body is invalid", async () => {
      const badRequestError = {
        response: { status: 400, data: { message: "Bad Request" } },
        message: "Request failed with status code 400",
      };
      vi.spyOn(httpService, "post").mockReturnValue(
        throwError(() => badRequestError),
      );

      await expect(service.createUser(createUserInput)).rejects.toThrow();
    });

    it("should throw an error when the username already exists", async () => {
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

      await expect(service.createUser(createUserInput)).rejects.toThrow();
    });

    it("should throw an error when the backend API returns an HTTP error", async () => {
      const httpError = new Error("Internal Server Error");
      vi.spyOn(httpService, "post").mockReturnValue(
        throwError(() => httpError),
      );

      await expect(service.createUser(createUserInput)).rejects.toThrow(
        "Internal Server Error",
      );
    });
  });

  describe("deleteUserById", () => {
    const userId = "550e8400-e29b-41d4-a716-446655440000";

    it("should delete a user successfully", async () => {
      vi.spyOn(httpService, "delete").mockReturnValue(
        of({ status: 204 } as AxiosResponse),
      );

      const result = await service.deleteUserById(userId);

      expect(httpService.delete).toHaveBeenCalledWith(`/api/users/${userId}`);
      expect(result).toBe(userId);
    });

    it("should throw an error when the user is not found", async () => {
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

      await expect(service.deleteUserById(userId)).rejects.toThrow();
    });

    it("should throw an error when the backend API returns an HTTP error", async () => {
      const httpError = new Error("Internal Server Error");
      vi.spyOn(httpService, "delete").mockReturnValue(
        throwError(() => httpError),
      );

      await expect(service.deleteUserById(userId)).rejects.toThrow(
        "Internal Server Error",
      );
    });
  });
});
