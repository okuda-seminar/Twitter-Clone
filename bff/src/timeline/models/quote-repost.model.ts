import { Field, ID, ObjectType } from "@nestjs/graphql";
import { NullableUuid } from "./nullable-uuid";

@ObjectType()
export class QuoteRepost {
  @Field()
  type: "quoteRepost";

  @Field(() => ID)
  id: string;

  @Field(() => ID)
  authorId: string;

  @Field(() => NullableUuid)
  parentPostId: NullableUuid;

  @Field()
  text: string;

  @Field()
  createdAt: string;
}
