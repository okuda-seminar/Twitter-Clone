import { Box } from "@chakra-ui/react";
import type { Meta, StoryObj } from "@storybook/react";
import { fn } from "@storybook/test";
import { NewPostsBanner } from "./new-posts-banner";

const meta: Meta<typeof NewPostsBanner> = {
  title: "Features/NewPostsBanner",
  component: NewPostsBanner,
  decorators: [
    (Story) => (
      <Box width="600px">
        <Story />
      </Box>
    ),
  ],
  args: {
    onLoadNewPosts: fn(),
  },
};

export default meta;
type Story = StoryObj<typeof NewPostsBanner>;

export const NoNewPosts: Story = {
  args: {
    count: 0,
  },
};

export const SingleNewPost: Story = {
  args: {
    count: 1,
  },
};

export const MultipleNewPosts: Story = {
  args: {
    count: 5,
  },
};
