import type { Meta, StoryObj } from "@storybook/react";
import { expect, userEvent, within } from "@storybook/test";
import { Settings } from "./settings";

const meta: Meta<typeof Settings> = {
  title: "Features/Settings",
  component: Settings,
};

export default meta;
type Story = StoryObj<typeof Settings>;

export const Primary: Story = {};

export const FocusedState: Story = {
  play: async ({ canvasElement }) => {
    const canvas = within(canvasElement);

    const searchInput = canvas.getByPlaceholderText("Search Settings");

    await userEvent.click(searchInput);

    await expect(searchInput).toHaveFocus();

    const backButton = canvas.getByRole("button");
    await expect(backButton).toBeInTheDocument();

    const helpText = canvas.getByText(
      "Try searching for notifications, privacy, etc.",
    );
    await expect(helpText).toBeInTheDocument();
  },
};
