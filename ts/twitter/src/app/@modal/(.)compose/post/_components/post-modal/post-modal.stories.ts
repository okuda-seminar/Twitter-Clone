import { createPost } from "@/lib/actions/create-post.mock";
import { err, ok } from "@/lib/actions/types";
import type { Meta, StoryObj } from "@storybook/react";
import { expect, screen, userEvent, within } from "@storybook/test";
import { PostModal } from "./post-modal";

const meta: Meta<typeof PostModal> = {
  title: "Features/PostModal",
  component: PostModal,
  tags: ["!autodocs"],
};

export default meta;
type Story = StoryObj<typeof PostModal>;

export const Primary: Story = {
  async beforeEach() {
    createPost.mockImplementation(async () => {
      return ok({
        id: "d4ee3d00-57a1-4233-bc02-1a02c4a2d634",
        user_id: "960fe0d6-2cd8-442a-9db6-284975cbf18d",
        text: "Test Post",
        created_at: "2024-01-01T00:00:00Z",
      });
    });
  },
};

export const ErrorForm: Story = {
  async beforeEach() {
    createPost.mockImplementation(async () => {
      return err({
        status: 500,
        statusText: "Internal Server Error",
      });
    });
  },
  play: async () => {
    // The dialog component is appended to the end of the <body> tag,
    // but since canvasElement is only inside #root, we need to retrieve it from the screen.
    const canvas = within(screen.getByRole("dialog"));

    await userEvent.type(canvas.getByTestId("text"), "Test Post");

    await userEvent.click(canvas.getByTestId("post-button"));

    await expect(
      canvas.getByText(
        "Something went wrong, but don't fret - let's give it another shot.",
      ),
    ).toBeInTheDocument();
  },
};
