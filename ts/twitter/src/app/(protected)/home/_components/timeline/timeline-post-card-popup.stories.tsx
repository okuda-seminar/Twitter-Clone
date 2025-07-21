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

export const Primary: Story = {};

export const Open: Story = {
  args: {
    defaultOpen: true,
  },
};
