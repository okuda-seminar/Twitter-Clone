import { Text, VStack } from "@chakra-ui/react";

export function NotificationsVerifiedView() {
  return (
    <VStack gap={4} p={8} textAlign="center" alignItems="center">
      <Text fontSize="3xl" fontWeight="bold" lineHeight="shorter">
        Nothing to see here — yet
      </Text>

      <Text fontSize="md" maxW="500px">
        Likes, mentions, reposts, and a whole lot more — when it comes from a
        verified account, you'll find it here. Learn more
      </Text>
    </VStack>
  );
}
