import { Box, Button, Flex, Avatar, Icon, Text, Image } from "@chakra-ui/react";
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
  const isHovered = false; // ホバーの状態をここで設定

  return (
    <Flex
      direction="column"
      p={2}
      alignItems="center"
      height="100%"
      display={{ base: "none", sm: "flex" }}
      position="fixed"
      left={0}
      backgroundColor={"gray.100"}
    >
      <Box
        mt={4}
        mb={2.5}
        flexDirection={{ base: "column", xl: "row" }}
        alignItems="start"
      >
        <Box
          className={`hoverEffect ${isHovered ? "bg-blue-100" : ""}`}
          _hover={{ bg: "gray.200" }}
          borderRadius="full"
        >
          <Image
            src="https://help.twitter.com/content/dam/help-twitter/brand/logo.png"
            width="60px"
            height="60px"
          />
        </Box>
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
      <Button
        bg="blue.400"
        color="white"
        rounded="full"
        w="56"
        h="12"
        fontWeight="bold"
        boxShadow="md"
        _hover={{ filter: "brightness(95%)" }}
        fontSize="lg"
        display={{ base: "none", xl: "inline" }}
      >
        Tweet
      </Button>

      <Flex
        display="flex"
        alignItems="center"
        mt={{ base: 0, xl: 2 }}
        borderRadius="full"
        _hover={{ bg: "gray.200" }}
        p = {{ base: 0, xl: 3 }}
      >
        <Avatar
          src="https://eightsuzuki.github.io/images/profile.png"
          alt="user-img"
          size={{ base: "sm", xl: "md" }}
        />
        <Flex
          direction="row"
          display={{ base: "none", xl: "inline" }}
          ml={2}
          mr={2}
        >
          <Text fontWeight="bold">sugiki8</Text>
          <Text color="gray.500">@8Infu</Text>
        </Flex>
        <Flex direction="row" display={{ base: "none", xl: "inline" }} mr={2}>
          <DotsHorizontalIcon height="28px" />
        </Flex>
      </Flex>
    </Flex>
  );
}
