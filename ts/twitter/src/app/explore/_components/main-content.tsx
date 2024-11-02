"use client";

import React from "react";

import {
  Input,
  InputGroup,
  InputLeftElement,
  Tab,
  Tabs,
  TabIndicator,
  TabList,
  TabPanel,
  TabPanels,
  useColorModeValue,
  VStack,
} from "@chakra-ui/react";

import { IoIosSearch } from "react-icons/io";
import Feed from "@/lib/compoenents/feed";

const MainContent: React.FC = () => {
  return (
    <VStack>
      <SearchBar />
      <TabBar />
    </VStack>
  );
};

const SearchBar: React.FC = () => {
  return (
    <InputGroup>
      <InputLeftElement pointerEvents="none">
        <IoIosSearch color="gray.300" />
      </InputLeftElement>
      <Input placeholder="Search" />
    </InputGroup>
  );
};

const TabBar: React.FC = () => {
  return (
    <Tabs position="relative" variant="unstyled">
      <TabList>
        <Tab
          width="100px"
          _hover={{ background: useColorModeValue("gray.100", "transparent") }}
        >
          For You
        </Tab>
        <Tab
          width="100px"
          _hover={{ background: useColorModeValue("gray.100", "transparent") }}
        >
          Trending
        </Tab>
        <Tab
          width="100px"
          _hover={{ background: useColorModeValue("gray.100", "transparent") }}
        >
          News
        </Tab>
        <Tab
          width="100px"
          _hover={{ background: useColorModeValue("gray.100", "transparent") }}
        >
          Sports
        </Tab>
        <Tab
          width="130px"
          _hover={{ background: useColorModeValue("gray.100", "transparent") }}
        >
          Entertainment
        </Tab>
      </TabList>
      <TabIndicator mt="-1.5px" height="2px" bg="blue.500" borderRadius="1px" />
      <TabPanels>
        <TabPanel>
          <Feed />
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

export default MainContent;
