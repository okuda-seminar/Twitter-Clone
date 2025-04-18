import { Field, ID, ObjectType } from "@nestjs/graphql";

@ObjectType()
export class NullableUuid {
  @Field(() => ID, { nullable: true })
  UUID: string;

  @Field()
  Valid: boolean;
}
