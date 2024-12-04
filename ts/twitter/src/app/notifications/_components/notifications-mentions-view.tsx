import { Text, VStack } from "@chakra-ui/react";

export function NotificationsMentionsView() {
  return (
    <VStack spacing={4} p={8} textAlign="center">
      <Text fontSize="3xl" fontWeight="bold" lineHeight="shorter">
        Nothing to see here — yet
      </Text>
      <Text fontSize="md">When someone mentions you, you'll find it here.</Text>
    </VStack>
  );
}
