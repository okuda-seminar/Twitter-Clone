import type { Meta, StoryObj } from "@storybook/react";
import { HomeIcon } from "../icons";
import { IconButtonWithLink } from "./icon-button-with-link";

const meta: Meta<typeof IconButtonWithLink> = {
  title: "Features/IconButtonWithLink",
  component: IconButtonWithLink,
  args: {
    url: "/home",
    tooltipContent: "Home",
    ariaLabel: "Home",
    icon: <HomeIcon />,
  },
};

export default meta;
type Story = StoryObj<typeof IconButtonWithLink>;

export const Primary: Story = {
  parameters: {
    viewport: { defaultViewport: "xl" },
  },
};

export const Small: Story = {
  parameters: {
    viewport: { defaultViewport: "sm" },
  },
};
