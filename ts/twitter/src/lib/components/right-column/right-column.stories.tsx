import type { Meta, StoryObj } from "@storybook/react";
import { RightColumn } from "./right-column";

const meta: Meta<typeof RightColumn> = {
  title: "Features/RightColumn",
  component: RightColumn,
};

export default meta;
type Story = StoryObj<typeof RightColumn>;

export const Primary: Story = {};
