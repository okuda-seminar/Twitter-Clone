import { Test, TestingModule } from "@nestjs/testing";
import { UserResolver } from "./user.resolver";
import { UserService } from "./user.service";

describe("UserResolver", () => {
  let resolver: UserResolver;
  let userService: UserService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        UserResolver,
        {
          provide: UserService,
          useValue: {
            createUser: vi.fn(),
            deleteUserById: vi.fn(),
          },
        },
      ],
    }).compile();

    resolver = module.get<UserResolver>(UserResolver);
    userService = module.get<UserService>(UserService);
  });

  describe("createUser", () => {
    const createUserInput = {
      username: "testuser",
      display_name: "Test User",
      password: "password123",
    };

    const mockAuthenticatedUser = {
      token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9",
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

    it("should call UserService.createUser and return the result", async () => {
      vi.spyOn(userService, "createUser").mockResolvedValue(
        mockAuthenticatedUser,
      );

      const result = await resolver.createUser(createUserInput);

      expect(userService.createUser).toHaveBeenCalledWith(createUserInput);
      expect(result).toEqual(mockAuthenticatedUser);
    });
  });

  describe("deleteUserById", () => {
    const userId = "550e8400-e29b-41d4-a716-446655440000";

    it("should call UserService.deleteUserById and return userId", async () => {
      vi.spyOn(userService, "deleteUserById").mockResolvedValue(userId);

      const result = await resolver.deleteUserById(userId);

      expect(userService.deleteUserById).toHaveBeenCalledWith(userId);
      expect(result).toBe(userId);
    });
  });
});
