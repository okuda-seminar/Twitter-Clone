import type { User } from "@/lib/models/user";
import { Avatar, Button, Flex, HStack, Text, VStack } from "@chakra-ui/react";
import type React from "react";

interface UserRecommendationListProps {
  users: User[];
}

export const UserRecommendationList: React.FC<UserRecommendationListProps> = ({
  users,
}) => {
  return (
    <VStack align="stretch" width="full" px="1" gap="4">
      {users.map((user) => (
        <HStack
          key={user.id}
          alignItems="center"
          justify="space-between"
          px="3"
        >
          <Flex align="center">
            <Avatar.Root size="md">
              <Avatar.Fallback name={user.displayName} />
              <Avatar.Image />
            </Avatar.Root>

            <VStack mx="2" align="flex-start" gap="0">
              <Text fontWeight="medium">{user.displayName}</Text>
              <Text fontSize="sm" color="gray.500">
                @{user.username}
              </Text>
              {user.bio && (
                <Text fontSize="sm" color="gray.600">
                  {user.bio}
                </Text>
              )}
            </VStack>
          </Flex>

          <Button borderRadius="full" size="sm">
            Follow
          </Button>
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
