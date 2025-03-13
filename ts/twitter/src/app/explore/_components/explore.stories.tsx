import type { Meta, StoryObj } from "@storybook/react";
import { Explore } from "./explore";

const meta: Meta<typeof Explore> = {
  title: "Features/Explore",
  component: Explore,
};

export default meta;
type Story = StoryObj<typeof Explore>;

export const Primary: Story = {};
