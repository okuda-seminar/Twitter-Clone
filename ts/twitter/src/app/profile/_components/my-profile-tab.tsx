"use client";
import { Tabs } from "@chakra-ui/react";
import type React from "react";

export const MyProfileTab: React.FC = () => {
  const tabItems = ["Posts", "Highlights", "Articles", "Media", "Likes"];
  return (
    <Tabs.Root
      position="relative"
      width="100%"
      key="lines"
      defaultValue="Posts"
    >
      <Tabs.List width="100%" color="gray" position="relative">
        {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/471
        - Refactor My Profile Tab to Create Custom Component and Implement Light Mode Support. */}
        {tabItems.map((item) => (
          <Tabs.Trigger
            key={item}
            value={item}
            flex="1"
            justifyContent="center"
            _hover={{
              background: { base: "colors.gray.100", _dark: "transparent" },
            }}
            fontSize="md"
          >
            {item}
          </Tabs.Trigger>
        ))}
      </Tabs.List>
      <Tabs.Content value="Posts">
        <p>Posts</p>
      </Tabs.Content>
      <Tabs.Content value="Replies">
        <p>Replies</p>
      </Tabs.Content>
      <Tabs.Content value="Highlights">
        <p>Highlights</p>
      </Tabs.Content>
      <Tabs.Content value="Article">
        <p>Articles</p>
      </Tabs.Content>
      <Tabs.Content value="Media">
        <p>Medias</p>
      </Tabs.Content>
      <Tabs.Content value="Likes">
        <p>Likes</p>
      </Tabs.Content>
    </Tabs.Root>
  );
};
