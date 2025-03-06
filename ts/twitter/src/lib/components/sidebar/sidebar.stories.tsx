import type { Meta, StoryObj } from "@storybook/react";
import { SideBar } from "./sidebar";

const meta: Meta<typeof SideBar> = {
  title: "Features/SideBar",
  component: SideBar,
};

export default meta;
type Story = StoryObj<typeof SideBar>;

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
