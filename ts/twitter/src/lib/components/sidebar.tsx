"use client";

import React from "react";
import {
  IconButton,
  Tooltip,
  VStack,
  Flex,
  Box,
  Text,
  Spacer,
} from "@chakra-ui/react";
import { SearchIcon, BellIcon, EmailIcon } from "@chakra-ui/icons";
import { PiHouseFill } from "react-icons/pi";
import { FaTwitter, FaUser } from "react-icons/fa";
import { BsSlashSquare, BsPeople } from "react-icons/bs";
import { CiCircleMore } from "react-icons/ci";
import Link from "next/link";
import IconButtonWithLink from "./icon-button-with-link";
import SignInbutton from "./sign-in-button";
import { SideBarPostButton } from "./sidebar-post-button";

export const SideBar: React.FC = () => {
  return (
    <Flex>
      <VStack marginBottom="24px" align="flex-start">
        <Link href="/home">
          <Tooltip label="twitter" placement="bottom">
            <Flex alignItems="center">
              <IconButton
                aria-label="Twitter"
                borderRadius="full"
                icon={<FaTwitter />}
                mx={4}
              />
            </Flex>
          </Tooltip>
        </Link>

        <IconButtonWithLink
          url={"/home"}
          tooltipText={"Home"}
          ariaLabel={"Home"}
          icon={<PiHouseFill />}
        />

        <IconButtonWithLink
          url={"/explore"}
          tooltipText={"Explore"}
          ariaLabel={"Explore"}
          icon={<SearchIcon />}
        />

        <IconButtonWithLink
          url={"/notifications"}
          tooltipText={"Notifications"}
          ariaLabel={"Notifications"}
          icon={<BellIcon />}
        />

        <IconButtonWithLink
          url={"/message"}
          tooltipText={"Message"}
          ariaLabel={"Message"}
          icon={<EmailIcon />}
        />

        <IconButtonWithLink
          url={"/groc"}
          tooltipText={"Groc"}
          ariaLabel={"Groc"}
          icon={<BsSlashSquare />}
        />

        <IconButtonWithLink
          url={"/community"}
          tooltipText={"Community"}
          ariaLabel={"Community"}
          icon={<BsPeople />}
        />

        <IconButtonWithLink
          url={"/profile"}
          tooltipText={"Profile"}
          ariaLabel={"Profile"}
          icon={<FaUser />}
        />
        <Flex>
          <Tooltip label="More" placement="bottom">
            <Box display={{ base: "inline", xl: "none" }}>
              <IconButton aria-label="More" icon={<CiCircleMore />} mx={4} />
            </Box>
          </Tooltip>
          <Box display={{ base: "none", xl: "flex" }}>
            <IconButton aria-label="More" icon={<CiCircleMore />} mx={4} />
            <Text fontWeight="bold">More</Text>
          </Box>
        </Flex>

        <SideBarPostButton />
        <Spacer />
        <SignInbutton />
      </VStack>
    </Flex>
  );
};
