"use client";
import {
  Box,
  Tab,
  TabIndicator,
  TabList,
  TabPanel,
  TabPanels,
  Tabs,
  useColorModeValue,
} from "@chakra-ui/react";
import type React from "react";
import { TimelineFeed } from "./timeline/timeline-feed";
import { useTimelineFeed } from "./timeline/use-timeline-feed";

export const Home: React.FC = () => {
  const { posts, errorMessage } = useTimelineFeed();
  const tabItems = ["For you", "Following"];
  return (
    <Box>
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
            <TimelineFeed posts={posts} errorMessage={errorMessage} />
          </TabPanel>
        </TabPanels>
      </Tabs>
    </Box>
  );
};
