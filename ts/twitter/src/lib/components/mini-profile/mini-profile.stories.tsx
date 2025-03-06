import type { Meta, StoryObj } from "@storybook/react";
import { MiniProfile } from "./mini-profile";

const meta: Meta<typeof MiniProfile> = {
  title: "Features/MiniProfile",
  component: MiniProfile,
  args: {
    user: {
      name: "Test User",
      id: "test123",
    },
  },
};

export default meta;
type Story = StoryObj<typeof MiniProfile>;

export const Primary: Story = {};
