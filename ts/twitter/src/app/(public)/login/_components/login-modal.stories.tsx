import { err, ok } from "@/lib/actions/types";
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

export const AccountForm: Story = {
  play: async ({ canvasElement }) => {
    const canvas = within(canvasElement);

    expect(canvas.getByText("Sign in to X")).toBeInTheDocument();

    const usernameInput = canvas.getByPlaceholderText(
      "Phone, email or username",
    );
    await userEvent.type(usernameInput, "testuser");

    const nextButton = canvas.getByRole("button", { name: "Next" });
    expect(nextButton).not.toBeDisabled();
  },
};

export const PasswordForm: Story = {
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

    const nextButton = canvas.getByRole("button", { name: "Next" });
    await userEvent.click(nextButton);

    expect(canvas.getByText("Enter your password")).toBeInTheDocument();

    const passwordInput = canvas.getByPlaceholderText("Password");
    await userEvent.type(passwordInput, "swweeweerd");

    const loginButton = canvas.getByRole("button", { name: "Log in" });
    expect(loginButton).not.toBeDisabled();
  },
};

export const LoginFailed: Story = {
  async beforeEach() {
    login.mockImplementation(async () => {
      return err({
        status: HTTP_STATUS.UNAUTHORIZED,
        statusText: "Invalid username or password",
      });
    });
  },
  play: async ({ canvasElement }) => {
    const canvas = within(canvasElement);

    const usernameInput = canvas.getByPlaceholderText(
      "Phone, email or username",
    );
    await userEvent.type(usernameInput, "testuser");

    const nextButton = canvas.getByRole("button", { name: "Next" });
    await userEvent.click(nextButton);

    expect(canvas.getByText("Enter your password")).toBeInTheDocument();

    const passwordInput = canvas.getByPlaceholderText("Password");
    await userEvent.type(passwordInput, "ssdsdwdwee");

    const loginButton = canvas.getByRole("button", { name: "Log in" });
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

    const nextButton = canvas.getByRole("button", { name: "Next" });
    await userEvent.click(nextButton);

    expect(canvas.getByText("Enter your password")).toBeInTheDocument();

    const passwordInput = canvas.getByPlaceholderText("Password");
    await userEvent.type(passwordInput, "ssdsdwdedw");

    const loginButton = canvas.getByRole("button", { name: "Log in" });
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

    const nextButton = canvas.getByRole("button", { name: "Next" });
    await userEvent.click(nextButton);

    expect(canvas.getByText("Enter your password")).toBeInTheDocument();

    const backButton = canvas.getByRole("button", { name: "Back to account" });
    await userEvent.click(backButton);

    expect(canvas.getByText("Sign in to X")).toBeInTheDocument();
  },
};
