"use client";
import {
  Tab,
  TabIndicator,
  TabList,
  TabPanel,
  TabPanels,
  Tabs,
  useColorModeValue,
} from "@chakra-ui/react";
import type React from "react";

export const SearchTabBar: React.FC = () => {
  const tabItems = ["For you", "Trending", "News", "Sports", "Entertainment"];

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
            fontSize={"sm"}
          >
            {item}
          </Tab>
        ))}
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
