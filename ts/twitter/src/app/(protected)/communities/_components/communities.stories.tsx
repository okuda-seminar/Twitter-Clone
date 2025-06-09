import type { Meta, StoryObj } from "@storybook/react";
import { Communities } from "./communities";

const meta: Meta<typeof Communities> = {
  title: "Features/Communities",
  component: Communities,
};

export default meta;
type Story = StoryObj<typeof Communities>;

export const Primary: Story = {};
