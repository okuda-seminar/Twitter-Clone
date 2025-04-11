import { err, ok } from "@/lib/actions/types";
import { STATUS_TEXT } from "@/lib/constants/error-messages";
import { HTTP_STATUS } from "@/lib/constants/http-status";
import type { Meta, StoryObj } from "@storybook/react";
import { expect, userEvent, within } from "@storybook/test";
import { login } from "#src/lib/actions/mocks/login.mock";
import { LoginModal } from "./login-modal";

const meta: Meta<typeof LoginModal> = {
  title: "Features/LoginModal",
  component: LoginModal,
  tags: ["!autodocs"],
};

export default meta;
type Story = StoryObj<typeof LoginModal>;

export const AccountView: Story = {
  play: async ({ canvasElement }) => {
    const canvas = within(canvasElement);

    await expect(canvas.findByText("Login to X")).resolves.toBeInTheDocument();

    const usernameInput = canvas.getByPlaceholderText(
      "Phone, email or username",
    );
    await userEvent.type(usernameInput, "testuser");

    const nextButton = canvas.getByRole("button", { name: /next/i });
    expect(nextButton).not.toBeDisabled();
  },
};

export const PasswordView: Story = {
  async beforeEach() {
    login.mockImplementation(async () => {
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
  play: async ({ canvasElement }) => {
    const canvas = within(canvasElement);

    const usernameInput = canvas.getByPlaceholderText(
      "Phone, email or username",
    );
    await userEvent.type(usernameInput, "testuser");

    const nextButton = canvas.getByRole("button", { name: /next/i });
    await userEvent.click(nextButton);

    await expect(
      canvas.findByText("Enter your password"),
    ).resolves.toBeInTheDocument();

    const passwordInput = canvas.getByPlaceholderText("Password");
    await userEvent.type(passwordInput, "securepassword1");

    const loginButton = canvas.getByRole("button", { name: /login/i });
    expect(loginButton).not.toBeDisabled();
  },
};

export const LoginFailed: Story = {
  async beforeEach() {
    login.mockImplementation(async () => {
      return err({
        status: HTTP_STATUS.UNAUTHORIZED,
        statusText: STATUS_TEXT.INVALID_CREDENTIALS,
      });
    });
  },
  play: async ({ canvasElement }) => {
    const canvas = within(canvasElement);

    const usernameInput = canvas.getByPlaceholderText(
      "Phone, email or username",
    );
    await userEvent.type(usernameInput, "testuser");

    const nextButton = canvas.getByRole("button", { name: /next/i });
    await userEvent.click(nextButton);

    await expect(
      canvas.findByText("Enter your password"),
    ).resolves.toBeInTheDocument();

    const passwordInput = canvas.getByPlaceholderText("Password");
    await userEvent.type(passwordInput, "wrongpassword");

    const loginButton = canvas.getByRole("button", { name: /login/i });
    await userEvent.click(loginButton);

    await expect(
      canvas.findByText(/Login failed/),
    ).resolves.toBeInTheDocument();
  },
};

export const NetworkError: Story = {
  async beforeEach() {
    login.mockImplementation(async () => {
      throw new Error("Network connection failed");
    });
  },
  play: async ({ canvasElement }) => {
    const canvas = within(canvasElement);

    const usernameInput = canvas.getByPlaceholderText(
      "Phone, email or username",
    );
    await userEvent.type(usernameInput, "testuser");

    const nextButton = canvas.getByRole("button", { name: /next/i });
    await userEvent.click(nextButton);

    await expect(
      canvas.findByText("Enter your password"),
    ).resolves.toBeInTheDocument();

    const passwordInput = canvas.getByPlaceholderText("Password");
    await userEvent.type(passwordInput, "testpassword");

    const loginButton = canvas.getByRole("button", { name: /login/i });
    await userEvent.click(loginButton);

    await expect(
      canvas.findByText(/Network error/),
    ).resolves.toBeInTheDocument();
  },
};

export const BackNavigation: Story = {
  play: async ({ canvasElement }) => {
    const canvas = within(canvasElement);

    const usernameInput = canvas.getByPlaceholderText(
      "Phone, email or username",
    );
    await userEvent.type(usernameInput, "testuser");

    const nextButton = canvas.getByRole("button", { name: /next/i });
    await userEvent.click(nextButton);

    await expect(
      canvas.findByText("Enter your password"),
    ).resolves.toBeInTheDocument();

    const backButton = canvas.getByRole("button", { name: /back to account/i });
    await userEvent.click(backButton);

    await expect(canvas.findByText("Login to X")).resolves.toBeInTheDocument();
  },
};
