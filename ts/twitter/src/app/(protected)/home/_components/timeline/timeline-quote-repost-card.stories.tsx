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
      parentPostId: { UUID: "1", Valid: true },
      authorId: "test",
      text: "This is my comment on the original post",
      createdAt: "2024-01-01T00:00:00Z",
    },
    parentPost: {
      type: "post",
      id: "1",
      authorId: "original-author",
      text: "This is the original post that was quoted",
      createdAt: "2023-12-31T00:00:00Z",
    },
  },
};

export const WithLongQuoteText: Story = {
  args: {
    quoteRepost: {
      type: "quoteRepost",
      id: "2",
      parentPostId: { UUID: "1", Valid: true },
      authorId: "test",
      text: "This is a very long quote repost comment that contains multiple sentences and will test how the component handles lengthy text. It should wrap properly and maintain good readability throughout. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      createdAt: "2024-01-01T00:00:00Z",
    },
    parentPost: {
      type: "post",
      id: "1",
      authorId: "original-author",
      text: "This is the original post that was quoted",
      createdAt: "2023-12-31T00:00:00Z",
    },
  },
};

export const WithMultilineQuoteText: Story = {
  args: {
    quoteRepost: {
      type: "quoteRepost",
      id: "2",
      parentPostId: { UUID: "1", Valid: true },
      authorId: "test",
      text: "Line 1 of my comment\nLine 2 of my comment\nLine 3 of my comment",
      createdAt: "2024-01-01T00:00:00Z",
    },
    parentPost: {
      type: "post",
      id: "1",
      authorId: "original-author",
      text: "This is the original post that was quoted",
      createdAt: "2023-12-31T00:00:00Z",
    },
  },
};

export const WithSpecialCharacters: Story = {
  args: {
    quoteRepost: {
      type: "quoteRepost",
      id: "2",
      parentPostId: { UUID: "1", Valid: true },
      authorId: "test",
      text: "Great point! 🎉 @username #hashtag https://example.com 日本語",
      createdAt: "2024-01-01T00:00:00Z",
    },
    parentPost: {
      type: "post",
      id: "1",
      authorId: "original-author",
      text: "This is the original post that was quoted",
      createdAt: "2023-12-31T00:00:00Z",
    },
  },
};

export const WithLongParentPost: Story = {
  args: {
    quoteRepost: {
      type: "quoteRepost",
      id: "2",
      parentPostId: { UUID: "1", Valid: true },
      authorId: "test",
      text: "Interesting!",
      createdAt: "2024-01-01T00:00:00Z",
    },
    parentPost: {
      type: "post",
      id: "1",
      authorId: "original-author",
      text: "This is a very long original post that contains multiple sentences and will test how the quoted card handles lengthy parent posts. It should display properly within the quote card component. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      createdAt: "2023-12-31T00:00:00Z",
    },
  },
};

export const WithEmptyQuoteText: Story = {
  args: {
    quoteRepost: {
      type: "quoteRepost",
      id: "2",
      parentPostId: { UUID: "1", Valid: true },
      authorId: "test",
      text: "",
      createdAt: "2024-01-01T00:00:00Z",
    },
    parentPost: {
      type: "post",
      id: "1",
      authorId: "original-author",
      text: "This is the original post that was quoted",
      createdAt: "2023-12-31T00:00:00Z",
    },
  },
};

export const InvalidParentPostId: Story = {
  args: {
    quoteRepost: {
      type: "quoteRepost",
      id: "2",
      parentPostId: { UUID: "", Valid: false },
      authorId: "test",
      text: "This quote has an invalid parent post ID",
      createdAt: "2024-01-01T00:00:00Z",
    },
  },
};
