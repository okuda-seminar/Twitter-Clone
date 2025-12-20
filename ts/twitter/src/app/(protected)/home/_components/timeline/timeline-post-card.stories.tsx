import { Box } from "@chakra-ui/react";
import type { Meta, StoryObj } from "@storybook/react";
import { TimelinePostCard } from "./timeline-post-card";

const meta: Meta<typeof TimelinePostCard> = {
  title: "Features/TimelinePostCard",
  component: TimelinePostCard,
  decorators: [
    (Story) => (
      <Box width="600px">
        <Story />
      </Box>
    ),
  ],
};

export default meta;
type Story = StoryObj<typeof TimelinePostCard>;

export const Primary: Story = {
  args: {
    post: {
      type: "post",
      id: "123",
      authorId: "test",
      text: "test post",
      createdAt: "2024-01-01T00:00:00Z",
    },
  },
};
