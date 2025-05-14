import { ERROR_MESSAGES } from "@/lib/constants/error-messages";
import type { Meta, StoryObj } from "@storybook/react";
import { TimelineFeed } from "./timeline-feed";

const meta: Meta<typeof TimelineFeed> = {
  title: "Features/TimelineFeed",
  component: TimelineFeed,
};

export default meta;
type Story = StoryObj<typeof TimelineFeed>;

export const Primary: Story = {
  args: {
    timelineItems: [
      {
        type: "post",
        id: "123",
        author_id: "test",
        text: "test post",
        created_at: "2024-01-01T00:00:00Z",
      },
      {
        type: "post",
        id: "123",
        author_id: "test",
        text: "test post 2",
        created_at: "2024-01-01T00:00:00Z",
      },
    ],
    errorMessage: null,
  },
};

export const ServerError: Story = {
  args: {
    timelineItems: [],
    errorMessage: ERROR_MESSAGES.SERVER_ERROR,
  },
};

export const EmptyPosts: Story = {
  args: {
    timelineItems: [],
    errorMessage: null,
  },
};
