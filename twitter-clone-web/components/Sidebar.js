import { Box, Button, Flex, Avatar, Icon, Text } from "@chakra-ui/react";
import {
  HomeIcon,
  BellIcon,
  BookmarkIcon,
  ClipboardIcon,
  DotsCircleHorizontalIcon,
  DotsHorizontalIcon,
  HashtagIcon,
  InboxIcon,
  UserIcon,
} from "@heroicons/react/solid";
import SidebarMenuItem from "./SidebarMenuItem";

export default function Sidebar() {
  return (
    <Box>
      <Box
        as="img"
        src="https://help.twitter.com/content/dam/help-twitter/brand/logo.png"
        alt="Twitter Logo"
        width="50"
        height="50"
      />
      <Box>
        <SidebarMenuItem text="Home" Icon={HomeIcon} active />
        <SidebarMenuItem text="Explore" Icon={HashtagIcon} />
        <SidebarMenuItem text="Notifications" Icon={BellIcon} />
        <SidebarMenuItem text="Messages" Icon={InboxIcon} />
        <SidebarMenuItem text="Bookmarks" Icon={BookmarkIcon} />
        <SidebarMenuItem text="Lists" Icon={ClipboardIcon} />
        <SidebarMenuItem text="Profile" Icon={UserIcon} />
        <SidebarMenuItem text="More" Icon={DotsCircleHorizontalIcon} />
      </Box>

      {/* profile */}

      <Flex alignItems="center">
        <Button colorScheme="blue" mr="4">
          Tweet
        </Button>

        <Flex alignItems="center">
          <Avatar
            src="https://eightsuzuki.github.io/images/profile.png"
            alt="user-img"
            size="sm"
            mr="2"
          />
          <Flex flexDirection="column">
            <Text fontWeight="bold">suzuki8</Text>
            <Text color="gray.500">@8Infu</Text>
          </Flex>
          <Icon as={DotsHorizontalIcon} boxSize={5} ml="2" />
        </Flex>
      </Flex>
    </Box>
  );
}
