import type { Meta, StoryObj } from "@storybook/react";
import { Settings } from "./settings";

const meta: Meta<typeof Settings> = {
  title: "Features/Settings",
  component: Settings,
};

export default meta;
type Story = StoryObj<typeof Settings>;

export const Primary: Story = {};
