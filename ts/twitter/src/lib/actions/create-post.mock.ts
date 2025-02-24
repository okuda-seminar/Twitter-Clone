import { fn } from "@storybook/test";
import * as actual from "./create-post";

export * from "./create-post";
export const createPost = fn(actual.createPost).mockName("createPost");
