import { logout } from "@/lib/actions/logout";
import type { User } from "@/lib/models/user";
import { Avatar, Box, Flex, IconButton, VStack } from "@chakra-ui/react";
import type React from "react";
import { useState } from "react";
import { MoreIcon } from "../icons";
import { useColorModeValue } from "../ui/color-mode";

interface MiniProfileProps {
  user: User;
}

export const MiniProfile: React.FC<MiniProfileProps> = ({ user }) => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const bgColor = useColorModeValue("white", "black");
  const textColor = useColorModeValue("black", "white");
  const hoverColor = useColorModeValue("gray.100", "gray.800");

  return (
    <Box position="relative">
      <Flex alignSelf="flex-start" mx={1} alignItems="center">
        <Avatar.Root size="xl">
          <Avatar.Fallback name={user.displayName} />
          <Avatar.Image />
        </Avatar.Root>
        <VStack mx={1} flex="1">
          <Box>{user.displayName}</Box>
          <Box>(ID: @{user.username})</Box>
        </VStack>
        <IconButton
          variant="ghost"
          size="sm"
          onClick={() => setIsMenuOpen(!isMenuOpen)}
        >
          <MoreIcon />
        </IconButton>
      </Flex>

      {isMenuOpen && (
        <Box
          position="absolute"
          bottom="100%"
          mb={2}
          bg={bgColor}
          color={textColor}
          borderRadius="md"
          boxShadow="lg"
          py={2}
          zIndex={10}
        >
          <Box px={4} py={2} cursor="pointer" _hover={{ bg: hoverColor }}>
            Add an existing account
          </Box>
          <Box
            px={4}
            py={2}
            cursor="pointer"
            _hover={{ bg: hoverColor }}
            onClick={() => {
              logout();
              setIsMenuOpen(false);
            }}
          >
            Logout @{user.username}
          </Box>
        </Box>
      )}
    </Box>
  );
};
