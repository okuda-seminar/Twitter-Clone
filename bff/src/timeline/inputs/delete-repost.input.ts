import { Field, InputType } from "@nestjs/graphql";

@InputType()
export class DeleteRepostInput {
  @Field()
  repost_id: string;
}
