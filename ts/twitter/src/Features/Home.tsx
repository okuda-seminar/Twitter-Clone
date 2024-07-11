import React from "react";
import "./Home.css";

import {
  Tab,
  Tabs,
  TabIndicator,
  TabList,
  TabPanel,
  TabPanels,
  useColorModeValue,
} from "@chakra-ui/react";

const Home: React.FC = () => {
  return (
    <Tabs position="relative" variant="unstyled">
      <TabList>
        <Tab
          width="200px"
          _hover={{ background: useColorModeValue("gray.100", "transparent") }}
        >
          For You
        </Tab>
        <Tab
          width="200px"
          _hover={{ background: useColorModeValue("gray.100", "transparent") }}
        >
          Following
        </Tab>
      </TabList>
      <TabIndicator mt="-1.5px" height="2px" bg="blue.500" borderRadius="1px" />
      <TabPanels>
        <TabPanel>
          <p>one!</p>
        </TabPanel>
        <TabPanel>
          <p>two!</p>
        </TabPanel>
      </TabPanels>
    </Tabs>
  );
};

export default Home;
