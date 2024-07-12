import React from "react";
import { IconButton, LinkOverlay, VStack } from "@chakra-ui/react";
import { SearchIcon } from "@chakra-ui/icons";
import { PiHouseFill } from "react-icons/pi";
import Link from "next/link";

const SideBar: React.FC = () => {
  return (
    <VStack>
      <Link href="/home">
        <IconButton aria-label="Home" icon={<PiHouseFill />}></IconButton>
      </Link>

      <Link href="/explore">
        <IconButton aria-label="Explore" icon={<SearchIcon />}></IconButton>
      </Link>
    </VStack>
  );
};

export default SideBar;
