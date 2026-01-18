import { Field, ID, ObjectType } from "@nestjs/graphql";

@ObjectType()
export class User {
  @Field(() => ID)
  id: string;

  @Field()
  username: string;

  @Field()
  displayName: string;

  @Field()
  bio: string;

  @Field()
  isPrivate: boolean;

  @Field()
  createdAt: string;

  @Field()
  updatedAt: string;
}
