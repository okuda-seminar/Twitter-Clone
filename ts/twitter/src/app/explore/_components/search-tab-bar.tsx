import React from "react";
import {
  Tabs,
  TabIndicator,
  TabList,
  TabPanel,
  TabPanels,
} from "@chakra-ui/react";
import { CustomTab } from "@/lib/components/custom-tab";

export const SearchTabBar: React.FC = () => {
  return (
    <Tabs position="relative" variant="unstyled">
      <TabList>
        <CustomTab tabWidth={"100px"} message={"For you"} fontSize={"sm"} />
        <CustomTab tabWidth={"100px"} message={"Trending"} fontSize={"sm"} />
        <CustomTab tabWidth={"100px"} message={"News"} fontSize={"sm"} />
        <CustomTab tabWidth={"100px"} message={"Sports"} fontSize={"sm"} />
        <CustomTab
          tabWidth={"100px"}
          message={"Entertainment"}
          fontSize={"xs"}
        />
      </TabList>
      <TabIndicator mt="-1.5px" height="2px" bg="blue.500" borderRadius="1px" />
      <TabPanels>
        <TabPanel>
          <p>posts for you</p>
        </TabPanel>
        <TabPanel>
          <p>trending</p>
        </TabPanel>
        <TabPanel>
          <p>news</p>
        </TabPanel>
        <TabPanel>
          <p>sports</p>
        </TabPanel>
        <TabPanel>
          <p>entertainment</p>
        </TabPanel>
      </TabPanels>
    </Tabs>
  );
};
