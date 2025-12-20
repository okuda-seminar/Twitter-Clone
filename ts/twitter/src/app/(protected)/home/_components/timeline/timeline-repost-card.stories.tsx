import type { Post } from "@/lib/models/post";
import { Box } from "@chakra-ui/react";
import type { Meta, StoryObj } from "@storybook/react";
import type { FC } from "react";
import { TimelineRepostCard } from "./timeline-repost-card";

const meta: Meta<typeof TimelineRepostCard> = {
  title: "Features/TimelineRepostCard",
  component: TimelineRepostCard,
  decorators: [
    (Story: FC) => (
      <Box width="600px">
        <Story />
      </Box>
    ),
  ],
};

export default meta;
type Story = StoryObj<typeof TimelineRepostCard>;

const mockParentPost: Post = {
  type: "post",
  id: "1",
  authorId: "test",
  text: "This is the original post that was reposted",
  createdAt: "2024-01-01T00:00:00Z",
};

export const Primary: Story = {
  args: {
    repost: {
      type: "repost",
      id: "2",
      parentPostId: { UUID: "1", Valid: true },
      authorId: "test",
      createdAt: "2024-01-01T00:00:00Z",
    },
    parentPost: mockParentPost,
  },
};

export const InvalidParentPostId: Story = {
  args: {
    repost: {
      type: "repost",
      id: "2",
      parentPostId: { UUID: "", Valid: false },
      authorId: "test",
      createdAt: "2024-01-01T00:00:00Z",
    },
  },
};
