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
      <Avatar size="md" name={user.name} />
      <VStack mx={1}>
        <Box>{user.name}</Box>
        <Box>(ID: {user.id})</Box>
      </VStack>
    </Flex>
  );
};
