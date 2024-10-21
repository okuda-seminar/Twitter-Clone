"use client";
import React from "react";
import {
  Divider,
  Tab,
  Tabs,
  TabIndicator,
  TabList,
  TabPanel,
  TabPanels,
  useColorModeValue,
} from "@chakra-ui/react";

export const MyProfileTab: React.FC = () => {
  return (
    <Tabs position="relative" variant="unstyled" width="100%">
      <TabList width="100%" color="gray">
        {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/471 - Refactor My Profile Tab to Create Custom Component and Implement Light Mode Support. */}
        <Tab
          flex={1}
          _hover={{ background: useColorModeValue("gray.100", "transparent") }}
          _selected={{ color: "white" }}
        >
          Posts
        </Tab>
        <Tab
          flex={1}
          _hover={{ background: useColorModeValue("gray.100", "transparent") }}
          _selected={{ color: "white" }}
        >
          Replies
        </Tab>
        <Tab
          flex={1}
          _hover={{ background: useColorModeValue("gray.100", "transparent") }}
          _selected={{ color: "white" }}
        >
          Highlights
        </Tab>
        <Tab
          flex={1}
          _hover={{ background: useColorModeValue("gray.100", "transparent") }}
          _selected={{ color: "white" }}
        >
          Article
        </Tab>
        <Tab
          flex={1}
          _hover={{ background: useColorModeValue("gray.100", "transparent") }}
          _selected={{ color: "white" }}
        >
          Media
        </Tab>
        <Tab
          flex={1}
          _hover={{ background: useColorModeValue("gray.100", "transparent") }}
          _selected={{ color: "white" }}
        >
          Likes
        </Tab>
      </TabList>
      <TabIndicator mt="-1.5px" height="2px" bg="blue.500" borderRadius="1px" />
      <Divider />
      <TabPanels>
        <TabPanel>
          <p>Posts</p>
        </TabPanel>
        <TabPanel>
          <p>Replies</p>
        </TabPanel>
        <TabPanel>
          <p>Highlights</p>
        </TabPanel>
        <TabPanel>
          <p>Articles</p>
        </TabPanel>
        <TabPanel>
          <p>Medias</p>
        </TabPanel>
        <TabPanel>
          <p>Likes</p>
        </TabPanel>
      </TabPanels>
    </Tabs>
  );
};
