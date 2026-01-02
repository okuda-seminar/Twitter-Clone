import { Args, ID, Mutation, Resolver } from "@nestjs/graphql";
import { CreateUserInput } from "./inputs/create-user.input";
import { AuthenticatedUser } from "./models/authenticated-user.model";
import { UserService } from "./user.service";

@Resolver()
export class UserResolver {
  constructor(private readonly userService: UserService) {}

  @Mutation(() => AuthenticatedUser)
  async createUser(
    @Args("createUserInput") createUserInput: CreateUserInput,
  ): Promise<AuthenticatedUser> {
    return this.userService.createUser(createUserInput);
  }

  @Mutation(() => ID)
  async deleteUserById(
    @Args("userId", { type: () => ID }) userId: string,
  ): Promise<string> {
    return this.userService.deleteUserById(userId);
  }
}
