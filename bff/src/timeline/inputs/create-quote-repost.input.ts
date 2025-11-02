import { Field, ID, InputType } from "@nestjs/graphql";

@InputType()
export class CreateQuoteRepostInput {
  @Field()
  post_id: string;

  @Field()
  text: string;
}
