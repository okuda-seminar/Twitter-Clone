import { HttpService } from "@nestjs/axios";
import { Injectable } from "@nestjs/common";
import { firstValueFrom } from "rxjs";
import { CreateUserInput } from "./inputs/create-user.input";
import { AuthenticatedUser } from "./models/authenticated-user.model";

@Injectable()
export class UserService {
  constructor(private readonly httpService: HttpService) {}

  /**
   * Creates a new user by sending the data to the backend API.
   *
   * @param createUserInput - An object containing the necessary data for creating a user.
   * @returns A promise that resolves to the AuthenticatedUser (token + user) as returned by the backend.
   */
  async createUser(
    createUserInput: CreateUserInput,
  ): Promise<AuthenticatedUser> {
    const { data } = await firstValueFrom(
      this.httpService.post<AuthenticatedUser>("/api/users", createUserInput),
    );

    return data;
  }

  /**
   * Deletes a user by sending the data to the backend API.
   *
   * @param userId - The ID of the user to be deleted.
   * @returns A promise that resolves to the deleted user ID.
   */
  async deleteUserById(userId: string): Promise<string> {
    await firstValueFrom(this.httpService.delete(`/api/users/${userId}`));

    return userId;
  }
}
