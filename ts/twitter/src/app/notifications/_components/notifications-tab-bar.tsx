"use client";
import {
  Divider,
  Tab,
  TabIndicator,
  TabList,
  TabPanel,
  TabPanels,
  Tabs,
  useColorModeValue,
} from "@chakra-ui/react";
import type React from "react";
import { NotificationsAllView } from "./notifications-all-view";
import { NotificationsMentionsView } from "./notifications-mentions-view";
import { NotificationsVerifiedView } from "./notifications-verified-view";

export const NotificationsTabBar: React.FC = () => {
  const tabItems = ["All", "Verified", "Mentions"];

  return (
    <Tabs position="relative" variant="unstyled" width="100%">
      <TabList display="flex" width="100%" justifyContent="space-between">
        {tabItems.map((item) => (
          <Tab
            key={item}
            flex="1"
            textAlign="center"
            _hover={{
              background: useColorModeValue("gray.100", "transparent"),
            }}
            fontSize={"lg"}
          >
            {item}
          </Tab>
        ))}
      </TabList>
      <Divider />
      <TabIndicator mt="-1.5px" height="2px" bg="blue.500" borderRadius="1px" />
      <TabPanels>
        <TabPanel>
          <NotificationsAllView />
        </TabPanel>
        <TabPanel>
          <NotificationsVerifiedView />
        </TabPanel>
        <TabPanel>
          <NotificationsMentionsView />
        </TabPanel>
      </TabPanels>
    </Tabs>
  );
};
