import React from "react";
import { IconButton, Tooltip, VStack } from "@chakra-ui/react";
import { SearchIcon } from "@chakra-ui/icons";
import { PiHouseFill } from "react-icons/pi";
import Link from "next/link";

const SideBar: React.FC = () => {
  return (
    <VStack marginBottom="48px">
      <Link href="/home">
        <Tooltip label="Home" placement="bottom">
          <IconButton aria-label="Home" icon={<PiHouseFill />} />
        </Tooltip>
      </Link>

      <Link href="/explore">
        <Tooltip label="Explore" placement="bottom">
          <IconButton aria-label="Explore" icon={<SearchIcon />} />
        </Tooltip>
      </Link>
    </VStack>
  );
};

export default SideBar;
