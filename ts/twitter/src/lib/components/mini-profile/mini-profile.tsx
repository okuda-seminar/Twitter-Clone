import type { User } from "@/lib/models/user";
import { Avatar, Box, Flex, VStack } from "@chakra-ui/react";
import type React from "react";
interface MiniProfileProps {
  user: User;
}

export const MiniProfile: React.FC<MiniProfileProps> = ({ user }) => {
  return (
    <Flex alignSelf="flex-start" mx={1}>
      <Avatar.Root size="xl">
        <Avatar.Fallback name={user.displayName} />
        <Avatar.Image />
      </Avatar.Root>
      <VStack mx={1}>
        <Box>{user.displayName}</Box>
        <Box>(ID: {user.id})</Box>
      </VStack>
    </Flex>
  );
};
