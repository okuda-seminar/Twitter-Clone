import type { Meta, StoryObj } from "@storybook/react";
import { expect, fn, screen, within } from "@storybook/test";
import { NewMessageModal } from "./new-message-modal";

const meta = {
  title: "Features/NewMessageModal",
  component: NewMessageModal,
  parameters: {
    layout: "centered",
  },
  tags: ["autodocs"],
  argTypes: {
    open: {
      description: "Whether the modal is open or closed",
      control: { type: "boolean" },
    },
    onClose: {
      description: "Callback function called when the modal should be closed",
      action: "onClose",
    },
  },
  args: {
    onClose: fn(),
  },
} satisfies Meta<typeof NewMessageModal>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {
  args: {
    open: true,
  },
};

export const Closed: Story = {
  args: {
    open: false,
  },
};

export const LightMode: Story = {
  args: {
    open: true,
  },
  parameters: {
    backgrounds: { default: "light" },
  },
};

export const DarkMode: Story = {
  args: {
    open: true,
  },
  parameters: {
    backgrounds: { default: "dark" },
  },
};

export const Mobile: Story = {
  args: {
    open: true,
  },
  parameters: {
    viewport: { defaultViewport: "sm" },
  },
};

export const Desktop: Story = {
  args: {
    open: true,
  },
  parameters: {
    viewport: { defaultViewport: "xl" },
  },
};

export const InteractionTests: Story = {
  args: {
    open: true,
  },
  play: async () => {
    // The dialog component is appended to the end of the <body> tag,
    // but since canvasElement is only inside #root, we need to retrieve it from the screen.
    const canvas = within(screen.getByRole("dialog"));

    // Test that Next button is present and disabled
    const nextButton = canvas.getByRole("button", { name: /next/i });
    await expect(nextButton).toBeDisabled();

    // Test that close button is present and clickable
    const closeButton = canvas.getByRole("button", { name: /close/i });
    await expect(closeButton).toBeInTheDocument();
  },
};
