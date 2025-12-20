import { fn } from "@storybook/test";
import * as actual from "../create-quote-repost";

export * from "../create-quote-repost";
export const createQuoteRepost = fn(actual.createQuoteRepost).mockName(
  "createQuoteRepost",
);
