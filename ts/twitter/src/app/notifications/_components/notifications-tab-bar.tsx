import { CustomTab } from "@/lib/components/custom-tab";
import {
  Divider,
  TabIndicator,
  TabList,
  TabPanel,
  TabPanels,
  Tabs,
} from "@chakra-ui/react";
import type React from "react";
import { NotificationsAllView } from "./notifications-all-view";
import { NotificationsMentionsView } from "./notifications-mentions-view";
import { NotificationsVerifiedView } from "./notifications-verified-view";

export const NotificationsTabBar: React.FC = () => {
  return (
    <Tabs position="relative" variant="unstyled">
      <TabList>
        <CustomTab tabWidth={"100%"} message={"All"} fontSize={"lg"} />
        <CustomTab tabWidth={"100%"} message={"Verified"} fontSize={"lg"} />
        <CustomTab tabWidth={"100%"} message={"Mentions"} fontSize={"lg"} />
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
