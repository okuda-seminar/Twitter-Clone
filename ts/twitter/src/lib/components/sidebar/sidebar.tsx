"use client";

import { Flex, IconButton, Spacer, VStack } from "@chakra-ui/react";
import Link from "next/link";
import type React from "react";
import { useAuth } from "../auth-context";

import { IconButtonWithLink } from "../icon-button-with-link/icon-button-with-link";
import {
  BookmarksIcon,
  CommunityIcon,
  GrokIcon,
  HomeIcon,
  MailIcon,
  NotificationIcon,
  ProfileIcon,
  SearchIcon,
  XIcon,
} from "../icons";
import { MiniProfile } from "../mini-profile/mini-profile";
import { MorePopup } from "../more-popup/more-popup";

import { SideBarPostButton } from "../sidebar-post-button/sidebar-post-button";
import { useColorModeValue } from "../ui/color-mode";
import { Tooltip } from "../ui/tooltip";

export const SideBar: React.FC = () => {
  const { user } = useAuth();
  const sidebarItems = [
    {
      url: "/home",
      tooltipContent: "Home",
      ariaLabel: "Home",
      icon: <HomeIcon />,
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
      icon: <NotificationIcon />,
    },
    {
      url: "/message",
      tooltipContent: "Message",
      ariaLabel: "Message",
      icon: <MailIcon />,
    },
    {
      url: "/grok",
      tooltipContent: "Grok",
      ariaLabel: "Grok",
      icon: <GrokIcon />,
    },
    {
      url: "/communities",
      tooltipContent: "Communities",
      ariaLabel: "Communities",
      icon: <CommunityIcon />,
    },
    {
      url: "/bookmarks",
      tooltipContent: "Bookmarks",
      ariaLabel: "Bookmarks",
      icon: <BookmarksIcon />,
    },
    {
      url: "/profile",
      tooltipContent: "Profile",
      ariaLabel: "Profile",
      icon: <ProfileIcon />,
    },
  ];
  return (
    <Flex>
      <VStack marginBottom="24px" align="flex-start" gap="1">
        <Link href="/home">
          <Tooltip content="twitter" positioning={{ placement: "bottom" }}>
            <Flex alignItems="center">
              <IconButton
                aria-label="Twitter"
                borderRadius="full"
                mx={3}
                color={useColorModeValue("black", "white")}
                bg={useColorModeValue("white", "black")}
              >
                <XIcon />
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

        <MorePopup />

        <SideBarPostButton />
        <Spacer />
        {user && <MiniProfile user={user} />}
      </VStack>
    </Flex>
  );
};
