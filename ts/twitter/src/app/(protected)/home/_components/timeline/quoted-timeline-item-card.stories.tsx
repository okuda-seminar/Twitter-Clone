import { Box } from "@chakra-ui/react";
import type { Meta, StoryObj } from "@storybook/react";
import type { FC } from "react";
import { QuotedTimelineItemCard } from "./quoted-timeline-item-card";

const meta: Meta<typeof QuotedTimelineItemCard> = {
  title: "Features/QuotedTimelineItemCard",
  component: QuotedTimelineItemCard,
  decorators: [
    (Story: FC) => (
      <Box width="600px" bg="white" p={4}>
        <Story />
      </Box>
    ),
  ],
};

export default meta;
type Story = StoryObj<typeof QuotedTimelineItemCard>;

export const WithPost: Story = {
  args: {
    quotedTimelineItem: {
      type: "post",
      id: "1",
      authorId: "original-author",
      text: "This is the original post that is being quoted",
      createdAt: "2023-12-31T00:00:00Z",
    },
  },
};

export const WithLongText: Story = {
  args: {
    quotedTimelineItem: {
      type: "post",
      id: "1",
      authorId: "original-author",
      text: "This is a very long post that contains a lot of text and will test how the component handles text wrapping and display. It should wrap properly and maintain good readability even with lengthy content. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      createdAt: "2023-12-31T00:00:00Z",
    },
  },
};

export const WithMultilineText: Story = {
  args: {
    quotedTimelineItem: {
      type: "post",
      id: "1",
      authorId: "original-author",
      text: "Line 1 of the post\nLine 2 of the post\nLine 3 of the post\n\nAnd a paragraph after an empty line.",
      createdAt: "2023-12-31T00:00:00Z",
    },
  },
};

export const WithSpecialCharacters: Story = {
  args: {
    quotedTimelineItem: {
      type: "post",
      id: "1",
      authorId: "original-author",
      text: "Hello! 🎉 @username #hashtag https://example.com 日本語テキスト",
      createdAt: "2023-12-31T00:00:00Z",
    },
  },
};

export const WithQuoteRepost: Story = {
  args: {
    quotedTimelineItem: {
      type: "quoteRepost",
      id: "2",
      authorId: "quote-author",
      parentPostId: { UUID: "1", Valid: true },
      text: "This is a nested quote repost that is being displayed in the quoted card",
      createdAt: "2024-01-01T00:00:00Z",
    },
  },
};

export const WithEmptyText: Story = {
  args: {
    quotedTimelineItem: {
      type: "post",
      id: "1",
      authorId: "original-author",
      text: "",
      createdAt: "2023-12-31T00:00:00Z",
    },
  },
};

export const WithShortText: Story = {
  args: {
    quotedTimelineItem: {
      type: "post",
      id: "1",
      authorId: "original-author",
      text: "Hi!",
      createdAt: "2023-12-31T00:00:00Z",
    },
  },
};
