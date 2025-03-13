import { Text, VStack } from "@chakra-ui/react";

export function NotificationsAllView() {
  return (
    <VStack spacing={4} p={8} textAlign="center" alignItems="center">
      <Text fontSize="3xl" fontWeight="bold" lineHeight="shorter">
        Nothing to see here — yet
      </Text>
      <Text fontSize="md" maxW="500px">
        From likes to reposts and a whole lot more, this is where all the action
        happens.
      </Text>
    </VStack>
  );
}
