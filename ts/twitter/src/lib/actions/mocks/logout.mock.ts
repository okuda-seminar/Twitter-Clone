import { fn } from "@storybook/test";
import * as actual from "../logout";

export * from "../logout";
export const logout = fn(actual.logout).mockName("logout");
