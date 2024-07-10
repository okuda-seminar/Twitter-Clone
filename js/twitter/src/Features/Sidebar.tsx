import React from "react";
import { IconButton, VStack } from "@chakra-ui/react";
import { SearchIcon } from "@chakra-ui/icons";
import { PiHouseFill } from "react-icons/pi";

const SideBar: React.FC = () => {
  return (
    <VStack>
      <IconButton
        aria-label="Home"
        icon={<PiHouseFill />}
        onClick={() => console.log("How are you?")}
      ></IconButton>
      <IconButton aria-label="Explore" icon={<SearchIcon />}></IconButton>
    </VStack>
  );
};

export default SideBar;
