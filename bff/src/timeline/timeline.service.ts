import { HttpService } from "@nestjs/axios";
import { Injectable } from "@nestjs/common";
import { firstValueFrom } from "rxjs";
import { CreatePostInput } from "./inputs/create-post.input";
import { CreateQuoteRepostInput } from "./inputs/create-quote-repost.input";
import { CreateRepostInput } from "./inputs/create-repost.input";
import { Post } from "./models/post.model";
import { QuoteRepost } from "./models/quote-repost.model";
import { TimelineItem } from "./models/timeline-item.model";

@Injectable()
export class TimelineService {
  constructor(private readonly httpService: HttpService) {}

  /**
   * Fetches the timeline posts for a specific user from the backend API.
   *
   * @param userId The unique identifier of the user whose posts are to be fetched.
   * @returns A promise that resolves to an array of TimelineItem objects (Post, Repost, or QuoteRepost).
   */
  async getUserPosts(userId: string): Promise<Array<typeof TimelineItem>> {
    const { data } = await firstValueFrom(
      this.httpService.get<Array<typeof TimelineItem>>(
        `/api/users/${userId}/posts`,
      ),
    );

    return data;
  }

  /**
   * Creates a new post by sending the data to the backend API.
   *
   * @param createPostInput - An object containing the necessary data for creating a post (e.g., userId, text).
   * @returns A promise that resolves to the newly created Post object as returned by the backend.
   */
  async createPost(createPostInput: CreatePostInput): Promise<Post> {
    const { data } = await firstValueFrom(
      this.httpService.post<Post>("/api/posts", createPostInput),
    );

    return data;
  }

  /**
   * Creates a new repost by sending the data to the backend API.
   *
   * @param createRepostInput - An object containing the necessary data for creating a repost (e.g., postId).
   * @returns A promise that resolves to the newly created Repost object as returned by the backend.
   */
  async createRepost(
    userId: string,
    createRepostInput: CreateRepostInput,
  ): Promise<Post> {
    const { data } = await firstValueFrom(
      this.httpService.post<Post>(
        `/api/users/${userId}/reposts`,
        createRepostInput,
      ),
    );

    return data;
  }

  /**
   * Creates a new quote repost by sending the data to the backend API.
   *
   * @param createQuoteRepostInput - An object containing the necessary data for creating a quote repost (e.g., postId).
   * @returns A promise that resolves to the newly created QuoteRepost object as returned by the backend.
   */
  async createQuoteRepost(
    userId: string,
    createQuoteRepostInput: CreateQuoteRepostInput,
  ): Promise<QuoteRepost> {
    const { data } = await firstValueFrom(
      this.httpService.post<QuoteRepost>(
        `/api/users/${userId}/quote_reposts`,
        createQuoteRepostInput,
      ),
    );

    return data;
  }
}
