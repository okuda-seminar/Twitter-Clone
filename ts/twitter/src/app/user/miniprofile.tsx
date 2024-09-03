import React from "react";
import { Box, VStack, Flex, Avatar } from "@chakra-ui/react";

interface User {
  name: string;
  id: string;
}

interface MiniProfileProps {
  user: User;
}

const MiniProfile: React.FC<MiniProfileProps> = ({ user }) => {
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
export default MiniProfile;
