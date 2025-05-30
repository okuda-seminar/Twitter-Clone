import { logout } from "@/lib/actions/logout";
import type { User } from "@/lib/models/user";
import { Avatar, Box, Flex, VStack } from "@chakra-ui/react";
import { Popover } from "@chakra-ui/react";
import type React from "react";
import { ThreeDotsIcon } from "../icons";
import { useColorModeValue } from "../ui/color-mode";

interface MiniProfileProps {
  user: User;
}

export const MiniProfile: React.FC<MiniProfileProps> = ({ user }) => {
  return (
    <Popover.Root>
      <Popover.Trigger asChild>
        <Flex
          alignSelf="flex-start"
          mx={1}
          alignItems="center"
          cursor="pointer"
          borderRadius="full"
          px={2}
          py={2}
          _hover={{ bg: useColorModeValue("gray.100", "gray.800") }}
          transition="background-color 0.2s"
        >
          <Avatar.Root size="xl">
            <Avatar.Fallback name={user.displayName} />
            <Avatar.Image />
          </Avatar.Root>
          <VStack mx={2} flex="1">
            <Box>{user.displayName}</Box>
            <Box>(ID: @{user.username})</Box>
          </VStack>
          <ThreeDotsIcon boxSize={5} />
        </Flex>
      </Popover.Trigger>

      <Popover.Positioner>
        <Popover.Content
          bg={useColorModeValue("white", "black")}
          color={useColorModeValue("black", "white")}
          borderRadius="md"
          boxShadow="lg"
        >
          <Popover.Body px={0} py={0}>
            <Box
              px={4}
              py={2}
              cursor="pointer"
              _hover={{ bg: useColorModeValue("gray.100", "gray.800") }}
            >
              Add an existing account
            </Box>
            <Box
              px={4}
              py={2}
              cursor="pointer"
              _hover={{ bg: useColorModeValue("gray.100", "gray.800") }}
              onClick={() => logout()}
            >
              Logout @{user.username}
            </Box>
          </Popover.Body>
        </Popover.Content>
      </Popover.Positioner>
    </Popover.Root>
  );
};
