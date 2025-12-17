import { RepostIcon } from "@/lib/components/icons";
import { IconButton } from "@chakra-ui/react";
import type { Meta, StoryObj } from "@storybook/react";
import { RepostQuoteMenu } from "./repost-quote-menu";

const meta: Meta<typeof RepostQuoteMenu> = {
  title: "Features/RepostQuoteMenu",
  component: RepostQuoteMenu,
  parameters: {
    layout: "centered",
  },
};

export default meta;
type Story = StoryObj<typeof RepostQuoteMenu>;

export const Primary: Story = {
  args: {
    onRepostClick: () => {},
    onQuoteClick: () => {},
  },
  render: (args) => (
    <RepostQuoteMenu {...args}>
      <IconButton aria-label="Repost" size="sm" variant="ghost">
        <RepostIcon boxSize="5" />
      </IconButton>
    </RepostQuoteMenu>
  ),
};
