import { Field, ID, InputType } from "@nestjs/graphql";

@InputType()
export class CreateRepostInput {
  @Field()
  post_id: string;
}
