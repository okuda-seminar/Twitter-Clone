import type { Meta, StoryObj } from "@storybook/react";
import { MyProfile } from "./my-profile";

const meta: Meta<typeof MyProfile> = {
  title: "Features/MyProfile",
  component: MyProfile,
  parameters: {
    // Disables Chromatic's snapshotting on a component level
    chromatic: { disableSnapshot: true },
  },
};

export default meta;
type Story = StoryObj<typeof MyProfile>;

export const Primary: Story = {
  args: {
    userProfile: {
      id: "123",
      username: "test",
      display_name: "test",
      bio: "test",
      is_private: false,
      created_at: "2024-01-01T00:00:00Z",
      updated_at: "2024-01-01T00:00:00Z",
    },
  },
};
