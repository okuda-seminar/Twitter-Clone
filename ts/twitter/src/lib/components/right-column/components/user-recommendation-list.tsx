import type { User } from "@/lib/models/user";
import {
  Avatar,
  Box,
  Button,
  Flex,
  HStack,
  Text,
  VStack,
} from "@chakra-ui/react";
import type React from "react";
import { useColorModeValue } from "../../ui/color-mode";

interface TrendingNewsListProps {
  users: User[];
}

export const UserRecommendationList: React.FC<TrendingNewsListProps> = ({
  users,
}) => {
  return (
    <VStack
      border="0.5px solid"
      borderColor={useColorModeValue("gray.200", "gray.700")}
      borderRadius="xl"
      align="stretch"
      width="full"
      px="1"
      gap="4"
    >
      <Text textAlign="left" fontSize="xl" mt="3" px="3" fontWeight="bold">
        Who to follow
      </Text>
      {users.map((user) => (
        <HStack
          key={user.id}
          alignItems="center"
          borderRadius="full"
          justify="space-between"
          px="3"
        >
          <Flex align="center">
            <Avatar.Root size="md">
              <Avatar.Fallback name={user.displayName} />
              <Avatar.Image />
            </Avatar.Root>
            <VStack mx={2} align="flex-start">
              <Box>{user.displayName}</Box>
              <Box color="gray">@{user.username}</Box>
            </VStack>
          </Flex>

          <Button borderRadius="full">follow</Button>
        </HStack>
      ))}
      <Button
        textAlign="left"
        justifyContent="flex-start"
        color="blue.primary"
        bg="transparent"
        mb="1"
      >
        Show more
      </Button>
    </VStack>
  );
};
