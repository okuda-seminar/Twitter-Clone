import { Providers } from "@/lib/components/providers";
import { SessionProvider } from "@/lib/components/session-context";
import type { Preview } from "@storybook/react";

const preview: Preview = {
  parameters: {
    layout: "centered",
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/i,
      },
    },
    viewport: {
      defaultViewport: "reset",
      viewports: {
        sm: {
          name: "sm",
          styles: { width: "480px", height: "100%" },
        },
        md: {
          name: "md",
          styles: { width: "768px", height: "100%" },
        },
        lg: {
          name: "lg",
          styles: { width: "992px", height: "100%" },
        },
        xl: {
          name: "xl",
          styles: { width: "1280px", height: "100%" },
        },
        "2xl": {
          name: "2xl",
          styles: { width: "1536px", height: "100%" },
        },
      },
    },
    nextjs: {
      appDirectory: true,
    },
  },
  tags: ["autodocs"],
  decorators: [
    (Story) => (
      <Providers>
        <SessionProvider>
          <Story />
        </SessionProvider>
      </Providers>
    ),
  ],
};

export default preview;
