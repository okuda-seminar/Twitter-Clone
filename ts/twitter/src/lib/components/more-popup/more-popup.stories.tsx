import type { Meta, StoryObj } from "@storybook/react";
import { MorePopup } from "./more-popup";

const meta: Meta<typeof MorePopup> = {
  title: "Features/MorePopup",
  component: MorePopup,
};

export default meta;
type Story = StoryObj<typeof MorePopup>;

const withViewport = (viewport: string) => ({
  parameters: {
    viewport: { defaultViewport: viewport },
  },
});

export const Primary: Story = {
  ...withViewport("xl"),
};

export const Open: Story = {
  args: {
    defaultOpen: true,
  },
  ...withViewport("xl"),
};

export const Small: Story = {
  ...withViewport("sm"),
};

export const SmallOpen: Story = {
  args: {
    defaultOpen: true,
  },
  ...withViewport("sm"),
};
