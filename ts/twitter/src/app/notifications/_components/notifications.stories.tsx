import type { Meta, StoryObj } from "@storybook/react";
import { Notifications } from "./notifications";

const meta: Meta<typeof Notifications> = {
  title: "Features/Notifications",
  component: Notifications,
  parameters: {
    // Disables Chromatic's snapshotting on a component level
    chromatic: { disableSnapshot: true },
  },
};

export default meta;
type Story = StoryObj<typeof Notifications>;

export const Primary: Story = {};
