"use client";

import { useColorModeValue } from "@/lib/components/ui/color-mode";
import { Tabs } from "@chakra-ui/react";
import type React from "react";

export const MyProfileTab: React.FC = () => {
  return (
    <Tabs.Root
      position="relative"
      width="100%"
      key="lines"
      defaultValue="posts"
    >
      <Tabs.List width="100%" color="gray" position="relative">
        {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/471
        - Refactor My Profile Tab to Create Custom Component and Implement Light Mode Support. */}
        <Tabs.Trigger
          value="posts"
          flex={1}
          _hover={{
            background: { base: "colors.gray.100", _dark: "transparent" },
          }}
          _selected={{ color: useColorModeValue("black", "white") }}
        >
          Posts
        </Tabs.Trigger>
        <Tabs.Trigger
          value="replies"
          flex={1}
          _hover={{
            background: { base: "colors.gray.100", _dark: "transparent" },
          }}
          _selected={{ color: useColorModeValue("black", "white") }}
        >
          Replies
        </Tabs.Trigger>
        <Tabs.Trigger
          value="highlights"
          flex={1}
          _hover={{
            background: { base: "colors.gray.100", _dark: "transparent" },
          }}
          _selected={{ color: useColorModeValue("black", "white") }}
        >
          Highlights
        </Tabs.Trigger>
        <Tabs.Trigger
          value="article"
          flex={1}
          _hover={{
            background: { base: "colors.gray.100", _dark: "transparent" },
          }}
          _selected={{ color: useColorModeValue("black", "white") }}
        >
          Article
        </Tabs.Trigger>
        <Tabs.Trigger
          value="media"
          flex={1}
          _hover={{
            background: { base: "colors.gray.100", _dark: "transparent" },
          }}
          _selected={{ color: useColorModeValue("black", "white") }}
        >
          Media
        </Tabs.Trigger>
        <Tabs.Trigger
          value="likes"
          flex={1}
          _hover={{
            background: { base: "colors.gray.100", _dark: "transparent" },
          }}
          _selected={{ color: useColorModeValue("black", "white") }}
        >
          Likes
        </Tabs.Trigger>
        <Tabs.Indicator
          bottom="0"
          position="absolute"
          height="2px"
          bg="blue.500"
          borderRadius="1px"
          zIndex="1"
        />
      </Tabs.List>
      <Tabs.Content value="posts">
        <p>Posts</p>
      </Tabs.Content>
      <Tabs.Content value="replies">
        <p>Replies</p>
      </Tabs.Content>
      <Tabs.Content value="highlights">
        <p>Highlights</p>
      </Tabs.Content>
      <Tabs.Content value="article">
        <p>Articles</p>
      </Tabs.Content>
      <Tabs.Content value="media">
        <p>Medias</p>
      </Tabs.Content>
      <Tabs.Content value="likes">
        <p>Likes</p>
      </Tabs.Content>
    </Tabs.Root>
  );
};
