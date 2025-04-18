import { Field, ID, ObjectType } from "@nestjs/graphql";

@ObjectType()
export class Post {
  @Field()
  type: "post";

  @Field(() => ID)
  id: string;

  @Field(() => ID)
  authorId: string;

  @Field()
  text: string;

  @Field()
  createdAt: string;
}
