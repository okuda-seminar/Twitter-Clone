import { fn } from "@storybook/test";
import * as actual from "../login";

export * from "../login";
export const login = fn(actual.login).mockName("login");
