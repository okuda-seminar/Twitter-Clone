import { Field, InputType } from "@nestjs/graphql";

@InputType()
export class LikePostInput {
  @Field()
  post_id: string;
}
