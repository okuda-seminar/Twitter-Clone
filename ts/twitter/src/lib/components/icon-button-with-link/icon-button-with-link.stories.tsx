import type { Meta, StoryObj } from "@storybook/react";
import { PiHouseFill } from "react-icons/pi";
import { IconButtonWithLink } from "./icon-button-with-link";

const meta: Meta<typeof IconButtonWithLink> = {
  title: "Features/IconButtonWithLink",
  component: IconButtonWithLink,
  args: {
    url: "/home",
    tooltipText: "Home",
    ariaLabel: "Home",
    icon: <PiHouseFill />,
  },
};

export default meta;
type Story = StoryObj<typeof IconButtonWithLink>;

export const Primary: Story = {};

export const Small: Story = {
  parameters: {
    viewport: { defaultViewport: "sm" },
  },
};
