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
        className={`hoverEffect ${isHovered ? "bg-blue-100" : ""}`}
        p={0}
        px={{ base: 0, xl: 1 }}
        _hover={{ bg: "gray.200" }}
        borderRadius="full"
      >
        <Image
          src="https://help.twitter.com/content/dam/help-twitter/brand/logo.png"
          width={50}
          height={50}
        />
      </Box>

      
      <Box
        mt={4}
        mb={2.5}
        flexDirection={{ base: "column", xl: "colimn" }}
        alignItems="start"
      >
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

      {/* <Flex alignItems="center">
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
          className="hoverEffect"
          color="gray.700"
          alignItems="center"
          justifyContent={{ base: "center", xl: "flex-start" }}
          mt="auto"
        >
          <Avatar
            src="https://eightsuzuki.github.io/images/profile.png"
            alt="user-img"
            size="sm"
            mr="2"
          />
          <Flex direction="column" className="leading-5 hidden xl:inline">
            <Text fontWeight="bold">sugiki8</Text>
            <Text color="gray.500">@8Infu</Text>
          </Flex>
          <DotsHorizontalIcon className="h-5 ml-8 hidden xl:inline" />
        </Flex>
      </Flex> */}
    </Flex>
  );
}
