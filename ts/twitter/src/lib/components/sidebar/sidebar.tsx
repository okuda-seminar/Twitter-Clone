"use client";

import { BellIcon, EmailIcon, SearchIcon } from "@chakra-ui/icons";
import {
  Flex,
  IconButton,
  Spacer,
  Text,
  VStack,
  useBreakpointValue,
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
import { Tooltip } from "../ui/tooltip";

export const SideBar: React.FC = () => {
  const isTooltipDisabled = useBreakpointValue({ base: false, xl: true });
  const sidebarItems = [
    {
      url: "/home",
      tooltipContent: "Home",
      ariaLabel: "Home",
      icon: <PiHouseFill />,
    },
    {
      url: "/explore",
      tooltipContent: "Explore",
      ariaLabel: "Explore",
      icon: <SearchIcon />,
    },
    {
      url: "/notifications",
      tooltipContent: "Notifications",
      ariaLabel: "Notifications",
      icon: <BellIcon />,
    },
    {
      url: "/message",
      tooltipContent: "Message",
      ariaLabel: "Message",
      icon: <EmailIcon />,
    },
    {
      url: "/groc",
      tooltipContent: "Groc",
      ariaLabel: "Groc",
      icon: <BsSlashSquare />,
    },
    {
      url: "/community",
      tooltipContent: "Community",
      ariaLabel: "Community",
      icon: <BsPeople />,
    },
    {
      url: "/profile",
      tooltipContent: "Profile",
      ariaLabel: "Profile",
      icon: <FaUser />,
    },
  ];
  return (
    <Flex>
      <VStack marginBottom="24px" align="flex-start">
        <Link href="/home">
          <Tooltip content="twitter" positioning={{ placement: "bottom" }}>
            <Flex alignItems="center">
              <IconButton
                aria-label="Twitter"
                borderRadius="full"
                mx={3}
                color="white"
                bg="black"
              >
                <FaTwitter />
              </IconButton>
            </Flex>
          </Tooltip>
        </Link>

        {sidebarItems.map((item) => (
          <IconButtonWithLink
            key={item.url}
            url={item.url}
            tooltipContent={item.tooltipContent}
            ariaLabel={item.ariaLabel}
            icon={item.icon}
          />
        ))}

        <Flex alignItems="center" p="12px">
          <Tooltip
            content="More"
            positioning={{ placement: "bottom" }}
            disabled={isTooltipDisabled}
          >
            <IconButton aria-label="More" color="white" bg="black">
              <CiCircleMore />
            </IconButton>
          </Tooltip>
          <Text
            fontWeight="bold"
            ml="20px"
            display={{ base: "none", xl: "flex" }}
          >
            More
          </Text>
        </Flex>

        <SideBarPostButton />
        <Spacer />
        <SignInbutton />
      </VStack>
    </Flex>
  );
};
