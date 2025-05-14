"use client";
import { Tabs } from "@chakra-ui/react";
import type React from "react";
import { NotificationsAllView } from "./notifications-all-view";
import { NotificationsMentionsView } from "./notifications-mentions-view";
import { NotificationsVerifiedView } from "./notifications-verified-view";

export const NotificationsTabBar: React.FC = () => {
  const tabItems = ["All", "Verified", "Mentions"];

  return (
    <Tabs.Root position="relative" width="100%" defaultValue="All">
      <Tabs.List display="flex" width="100%">
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
      <Tabs.Content value="All">
        <NotificationsAllView />
      </Tabs.Content>
      <Tabs.Content value="Verified">
        <NotificationsVerifiedView />
      </Tabs.Content>
      <Tabs.Content value="Mentions">
        <NotificationsMentionsView />
      </Tabs.Content>
    </Tabs.Root>
  );
};
