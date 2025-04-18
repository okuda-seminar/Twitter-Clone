import { Field, ID, ObjectType } from "@nestjs/graphql";
import { NullableUuid } from "./nullable-uuid";

@ObjectType()
export class Repost {
  @Field()
  type: "repost";

  @Field(() => ID)
  id: string;

  @Field(() => ID)
  authorId: string;

  @Field(() => NullableUuid)
  parentPostId: NullableUuid;

  @Field()
  createdAt: string;
}
