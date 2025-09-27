import { Box } from "@chakra-ui/react";
import type { Meta, StoryObj } from "@storybook/react";
import { TimelineQuoteRepostCard } from "./timeline-quote-repost-card";

const meta: Meta<typeof TimelineQuoteRepostCard> = {
  title: "Features/TimelineQuoteRepostCard",
  component: TimelineQuoteRepostCard,
  decorators: [
    (Story) => (
      <Box width="600px">
        <Story />
      </Box>
    ),
  ],
};

export default meta;
type Story = StoryObj<typeof TimelineQuoteRepostCard>;

export const Primary: Story = {
  args: {
    quoteRepost: {
      type: "quoteRepost",
      id: "2",
      parent_post_id: "1",
      author_id: "test",
      text: "quote repost",
      created_at: "2024-01-01T00:00:00Z",
    },
  },
};
