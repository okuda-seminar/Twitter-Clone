import type { Meta, StoryObj } from "@storybook/react";
import { MiniProfile } from "./mini-profile";

const meta: Meta<typeof MiniProfile> = {
  title: "Features/MiniProfile",
  component: MiniProfile,
  args: {
    user: {
      id: "test123",
      username: "testuser",
      displayName: "Test User",
      bio: "",
      isPrivate: false,
      createdAt: "2025-01-01T00:00:00Z",
      updatedAt: "2025-01-15T12:30:45Z",
    },
  },
};

export default meta;
type Story = StoryObj<typeof MiniProfile>;

export const Primary: Story = {};
