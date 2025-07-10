import type { Meta, StoryObj } from "@storybook/react";
import { Bookmarks } from "./bookmarks";

const meta: Meta<typeof Bookmarks> = {
  title: "Features/Bookmarks",
  component: Bookmarks,
};

export default meta;
type Story = StoryObj<typeof Bookmarks>;

export const Primary: Story = {};
