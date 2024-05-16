import { Box, Button, Flex, Text, Image, Avatar, Icon } from "@chakra-ui/react";
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
  PencilIcon,
  PlusIcon,
} from "@heroicons/react/solid";
import SidebarMenuItem from "./SidebarMenuItem";

export default function Sidebar() {
  const isHovered = false; // const isHovered = false; // Set the hover state here

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
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/88 - Define color constants and Remove all inline color definitions.
    >
      {/* Menu Button */}
      <Box
        mt={4}
        mb={2.5}
        flexDirection={{ base: "column", xl: "row" }}
        alignItems="start"
      >
        <Box
          className={`hoverEffect ${isHovered ? "bg-blue-100" : ""}`}
          display="flex"
          justifyContent="center"
          alignItems="center"
          // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/88 - Define color constants and Remove all inline color definitions.
          _hover={{ bg: "gray.200" }}
          // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/88 - Define color constants and Remove all inline color definitions.
          borderRadius="full"
          mb="20px"
        >
          <Image
            src="https://about.twitter.com/content/dam/about-twitter/x/brand-toolkit/logo-black.png.twimg.1920.png"
            width="30px"
            height="30px"
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

      {/* Tweet */}
      <Button
        bg="blue.400"
        // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/88 - Define color constants and Remove all inline color definitions.
        color="white"
        // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/90 - Support dark mode.
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

      <Button
        bg="blue.400"
        rounded="full"
        borderRadius="full"
        className="rounded-full bg-blue-200 p-2 hover:bg-blue-300 focus:outline-none"
        display={{ xl: "none" }}
        // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/88 - Define color constants and Remove all inline color definitions.
      >
        <PencilIcon height="28px" color="white" />
      </Button>

      <Flex
        className={`hoverEffect ${isHovered ? "bg-blue-100" : ""}`}
        display="flex"
        alignItems="center"
        position="absolute"
        bottom={2}
        _hover={{ bg: "gray.200" ,borderRadius:"full"}}
        // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/88 - Define color constants and Remove all inline color definitions.
        p={{ base: 0, xl: 3 }}
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
          <Text
            color="gray.500"
            // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/88 - Define color constants and Remove all inline color definitions.
          >
            @8Infu
          </Text>
        </Flex>
        <Flex direction="row" display={{ base: "none", xl: "inline" }} mr={2}>
          <DotsHorizontalIcon height="28px" />
        </Flex>
      </Flex>
    </Flex>
  );
}
