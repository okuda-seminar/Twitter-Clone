import { fn } from "@storybook/test";
import * as actual from "../signup";

export * from "../signup";
export const signup = fn(actual.signup).mockName("signup");
