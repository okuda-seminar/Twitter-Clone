import { Text, VStack } from "@chakra-ui/react";

export function NotificationsMentionsView() {
  return (
    <VStack gap={4} p={8} textAlign="center" alignItems="center">
      <Text fontSize="3xl" fontWeight="bold" lineHeight="shorter">
        Nothing to see here — yet
      </Text>
      <Text fontSize="md" maxW="500px">
        When someone mentions you, you'll find it here.
      </Text>
    </VStack>
  );
}
