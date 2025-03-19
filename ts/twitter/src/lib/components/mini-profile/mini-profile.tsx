import { Avatar, Box, Flex, VStack } from "@chakra-ui/react";
import type React from "react";

interface User {
  name: string;
  id: string;
}

interface MiniProfileProps {
  user: User;
}

export const MiniProfile: React.FC<MiniProfileProps> = ({ user }) => {
  return (
    <Flex alignSelf="flex-start" mx={1}>
      <Avatar.Root size="xl">
        <Avatar.Fallback name={user.name} />
        <Avatar.Image />
      </Avatar.Root>
      <VStack mx={1}>
        <Box>{user.name}</Box>
        <Box>(ID: {user.id})</Box>
      </VStack>
    </Flex>
  );
};
