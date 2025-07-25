import type { Meta, StoryObj } from "@storybook/react";
import { Messages } from "./messages";

const meta = {
  title: "Features/Messages",
  component: Messages,
  parameters: {
    layout: "centered",
  },
  tags: ["autodocs"],
} satisfies Meta<typeof Messages>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {};

export const LightMode: Story = {
  parameters: {
    backgrounds: { default: "light" },
  },
};

export const DarkMode: Story = {
  parameters: {
    backgrounds: { default: "dark" },
  },
};
