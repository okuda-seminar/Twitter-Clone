import { err, ok } from "@/lib/actions/types";
import { ERROR_MESSAGES, STATUS_TEXT } from "@/lib/constants/error-messages";
import type { Meta, StoryObj } from "@storybook/react";
import { expect, screen, userEvent, within } from "@storybook/test";
import { signup } from "#src/lib/actions/mocks/signup.mock";
import { SignupModal } from "./signup-modal";

const meta: Meta<typeof SignupModal> = {
  title: "Features/SignupModal",
  component: SignupModal,
  tags: ["!autodocs"],
};

export default meta;
type Story = StoryObj<typeof SignupModal>;

export const Primary: Story = {
  async beforeEach() {
    signup.mockImplementation(async () => {
      return ok({
        token: "mock-token-123",
        user: {
          id: "user-123",
          username: "testuser",
          displayName: "Test User",
          bio: "",
          isPrivate: false,
          createdAt: "2024-01-01T00:00:00Z",
          updatedAt: "2024-01-01T00:00:00Z",
        },
      });
    });
  },
};

export const ErrorForm: Story = {
  async beforeEach() {
    signup.mockImplementation(async () => {
      return err({
        status: 500,
        statusText: STATUS_TEXT.INTERNAL_SERVER_ERROR,
      });
    });
  },
  play: async () => {
    const canvas = within(screen.getByRole("dialog"));

    await userEvent.type(canvas.getByLabelText("Display name"), "Test User");

    await userEvent.type(canvas.getByLabelText("Password"), "securepassword");

    await userEvent.click(canvas.getByText("Register"));

    await expect(
      canvas.findByText(new RegExp(ERROR_MESSAGES.SIGNUP_ERROR)),
    ).resolves.toBeInTheDocument();
  },
};
