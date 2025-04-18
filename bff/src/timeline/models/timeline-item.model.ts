import { createUnionType } from "@nestjs/graphql";
import { Post } from "./post.model";
import { QuoteRepost } from "./quote-repost.model";
import { Repost } from "./repost.model";

export const TimelineItem = createUnionType({
  name: "TimelineItem",
  types: () => [Post, Repost, QuoteRepost] as const,
  resolveType(value) {
    switch (value.type) {
      case "post":
        return Post;
      case "repost":
        return Repost;
      case "quoteRepost":
        return QuoteRepost;
      default:
        return null;
    }
  },
});
