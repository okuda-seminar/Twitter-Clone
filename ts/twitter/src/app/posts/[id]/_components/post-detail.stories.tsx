import type { Meta, StoryObj } from "@storybook/react";
import { mockPost } from "../mocks/post";
import { PostDetail } from "./post-detail";

const meta: Meta<typeof PostDetail> = {
  title: "Features/PostDetail",
  component: PostDetail,
};

export default meta;
type Story = StoryObj<typeof PostDetail>;

export const Primary: Story = {
  args: {
    post: mockPost,
  },
};
