import React from "react";
import {
  Tabs,
  TabIndicator,
  TabList,
  TabPanel,
  TabPanels,
  Box,
} from "@chakra-ui/react";
import { CustomTab } from "@/lib/components/custom-tab";
import { TimelineFeed } from "./timeline/timeline-feed";

export const Home: React.FC = () => {
  return (
    <Box>
      <Tabs position="relative" variant="unstyled" defaultIndex={1}>
        <TabList>
          <CustomTab tabWidth={"50%"} message={"For you"} fontSize={"lg"} />
          <CustomTab tabWidth={"50%"} message={"Following"} fontSize={"lg"} />
        </TabList>
        <TabIndicator
          mt="-1.5px"
          height="2px"
          bg="blue.500"
          borderRadius="1px"
        />
        <TabPanels>
          <TabPanel>
            <Box>Posts for you.</Box>
          </TabPanel>
          <TabPanel>
            <TimelineFeed />
          </TabPanel>
        </TabPanels>
      </Tabs>
    </Box>
  );
};
