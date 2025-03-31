"use client";
import { Box, Tabs } from "@chakra-ui/react";
import type React from "react";
import { TimelineFeed } from "./timeline/timeline-feed";
import { useTimelineFeed } from "./timeline/use-timeline-feed";

export const Home: React.FC = () => {
  const { posts, errorMessage } = useTimelineFeed();
  const tabItems = ["For you", "Following"];
  return (
    <Tabs.Root position="relative" width="100%" defaultValue="For you">
      <Tabs.List display="flex" width="100%" justifyContent="space-between">
        {tabItems.map((item) => (
          <Tabs.Trigger
            key={item}
            value={item}
            flex="1"
            justifyContent="center"
            _hover={{
              background: { base: "colors.gray.100", _dark: "transparent" },
            }}
            fontSize={"lg"}
          >
            {item}
          </Tabs.Trigger>
        ))}
        <Tabs.Indicator
          bottom="0"
          position="absolute"
          height="2px"
          bg="blue.500"
          borderRadius="1px"
          zIndex="1"
        />
      </Tabs.List>
      <Tabs.Content value="For you">
        <Box>Posts for you.</Box>
      </Tabs.Content>
      <Tabs.Content value="Following">
        <TimelineFeed posts={posts} errorMessage={errorMessage} />
      </Tabs.Content>
    </Tabs.Root>
  );
};
