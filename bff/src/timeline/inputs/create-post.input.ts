import { Field, ID, InputType } from "@nestjs/graphql";

@InputType()
export class CreatePostInput {
  @Field(() => ID)
  user_id: string;

  @Field()
  text: string;
}
