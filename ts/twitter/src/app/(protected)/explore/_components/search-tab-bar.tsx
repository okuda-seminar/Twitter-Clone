"use client";
import { useColorModeValue } from "@/lib/components/ui/color-mode";
import { Tabs } from "@chakra-ui/react";
import type React from "react";
import ForYou from "./for-you";

export const SearchTabBar: React.FC = () => {
  const tabItems = ["For you", "Trending", "News", "Sports", "Entertainment"];

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
            fontSize={"sm"}
            _selected={{ color: useColorModeValue("black", "white") }}
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
        <ForYou />
      </Tabs.Content>
      <Tabs.Content value="Trending">
        <p>trending</p>
      </Tabs.Content>
      <Tabs.Content value="News">
        <p>news</p>
      </Tabs.Content>
      <Tabs.Content value="Sports">
        <p>sports</p>
      </Tabs.Content>
      <Tabs.Content value="Entertainment">
        <p>entertainment</p>
      </Tabs.Content>
    </Tabs.Root>
  );
};
