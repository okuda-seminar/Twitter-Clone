"use client";

import { BellIcon, EmailIcon, SearchIcon } from "@chakra-ui/icons";
import {
  Box,
  Flex,
  IconButton,
  Spacer,
  Text,
  Tooltip,
  VStack,
} from "@chakra-ui/react";
import Link from "next/link";
import type React from "react";
import { BsPeople, BsSlashSquare } from "react-icons/bs";
import { CiCircleMore } from "react-icons/ci";
import { FaTwitter, FaUser } from "react-icons/fa";
import { PiHouseFill } from "react-icons/pi";
import { IconButtonWithLink } from "../icon-button-with-link/icon-button-with-link";
import { SideBarPostButton } from "../sidebar-post-button/sidebar-post-button";
import { SignInbutton } from "../sign-in-button";

export const SideBar: React.FC = () => {
  const sidebarItems = [
    {
      url: "/home",
      tooltipText: "Home",
      ariaLabel: "Home",
      icon: <PiHouseFill />,
    },
    {
      url: "/explore",
      tooltipText: "Explore",
      ariaLabel: "Explore",
      icon: <SearchIcon />,
    },
    {
      url: "/notifications",
      tooltipText: "Notifications",
      ariaLabel: "Notifications",
      icon: <BellIcon />,
    },
    {
      url: "/message",
      tooltipText: "Message",
      ariaLabel: "Message",
      icon: <EmailIcon />,
    },
    {
      url: "/groc",
      tooltipText: "Groc",
      ariaLabel: "Groc",
      icon: <BsSlashSquare />,
    },
    {
      url: "/community",
      tooltipText: "Community",
      ariaLabel: "Community",
      icon: <BsPeople />,
    },
    {
      url: "/profile",
      tooltipText: "Profile",
      ariaLabel: "Profile",
      icon: <FaUser />,
    },
  ];
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
        {sidebarItems.map((item) => (
          <IconButtonWithLink
            key={item.url}
            url={item.url}
            tooltipText={item.tooltipText}
            ariaLabel={item.ariaLabel}
            icon={item.icon}
          />
        ))}
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
