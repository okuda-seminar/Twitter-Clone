import { Args, ID, Mutation, Query, Resolver } from "@nestjs/graphql";
import { CreatePostInput } from "./inputs/create-post.input";
import { CreateRepostInput } from "./inputs/create-repost.input";
import { Post } from "./models/post.model";
import { Repost } from "./models/repost.model";
import { TimelineItem } from "./models/timeline-item.model";
import { TimelineService } from "./timeline.service";

@Resolver()
export class TimelineResolver {
  constructor(private readonly timelineService: TimelineService) {}

  @Query(() => [TimelineItem])
  async getUserPosts(
    @Args("userId", { type: () => ID }) userId: string,
  ): Promise<Array<typeof TimelineItem>> {
    return this.timelineService.getUserPosts(userId);
  }

  @Query(() => [TimelineItem])
  async getReverseChronologicalHomeTimeline(
    @Args("userId", { type: () => ID }) userId: string,
  ): Promise<Array<typeof TimelineItem>> {
    return this.timelineService.getReverseChronologicalHomeTimeline(userId);
  }

  @Mutation(() => Post)
  async createPost(
    @Args("createPostInput") createPostInput: CreatePostInput,
  ): Promise<Post> {
    return this.timelineService.createPost(createPostInput);
  }

  @Mutation(() => Repost)
  async createRepost(
    @Args("userId", { type: () => ID }) userId: string,
    @Args("createRepostInput") createRepostInput: CreateRepostInput,
  ): Promise<Post> {
    return this.timelineService.createRepost(userId, createRepostInput);
  }
}
