import { Box } from "@chakra-ui/react";
import type { Meta, StoryObj } from "@storybook/react";
import { TimelineRepostCard } from "./timeline-repost-card";

const meta: Meta<typeof TimelineRepostCard> = {
  title: "Features/TimelineRepostCard",
  component: TimelineRepostCard,
  decorators: [
    (Story) => (
      <Box width="600px">
        <Story />
      </Box>
    ),
  ],
};

export default meta;
type Story = StoryObj<typeof TimelineRepostCard>;

export const Primary: Story = {
  args: {
    repost: {
      type: "repost",
      id: "2",
      parent_post_id: "1",
      author_id: "test",
      created_at: "2024-01-01T00:00:00Z",
    },
  },
};
