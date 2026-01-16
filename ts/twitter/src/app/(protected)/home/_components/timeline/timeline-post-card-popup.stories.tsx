import type { Meta, StoryObj } from "@storybook/react";
import { TimelinePostCardPopupMenu } from "./timeline-post-card-popup-menu";

const meta: Meta<typeof TimelinePostCardPopupMenu> = {
  title: "Features/TimelinePostCardPopupMenu",
  component: TimelinePostCardPopupMenu,
  parameters: {
    layout: "centered",
  },
};

export default meta;
type Story = StoryObj<typeof TimelinePostCardPopupMenu>;

export const MyPost: Story = {
  args: {
    isMyPost: true,
  },
};

export const MyPostOpen: Story = {
  args: {
    isMyPost: true,
    defaultOpen: true,
  },
};

export const OtherPost: Story = {
  args: {
    isMyPost: false,
  },
};

export const OtherPostOpen: Story = {
  args: {
    isMyPost: false,
    defaultOpen: true,
  },
};
