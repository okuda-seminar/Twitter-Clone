import type { Meta, StoryObj } from "@storybook/react";
import { Explore } from "./explore";

const meta: Meta<typeof Explore> = {
  title: "Features/Explore",
  component: Explore,
  parameters: {
    // Disables Chromatic's snapshotting on a component level
    chromatic: { disableSnapshot: true },
  },
};

export default meta;
type Story = StoryObj<typeof Explore>;

export const Primary: Story = {};
