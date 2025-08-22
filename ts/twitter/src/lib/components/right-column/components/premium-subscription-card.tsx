import { Button, Text, VStack } from "@chakra-ui/react";
import type React from "react";
import { useColorModeValue } from "../../ui/color-mode";

export const PremiumSubscriptionCard: React.FC = () => {
  return (
    <VStack
      border="0.5px solid"
      borderColor={useColorModeValue("gray.200", "gray.700")}
      borderRadius="xl"
      align="stretch"
      width="full"
      gap="2"
      p="3.5"
    >
      <Text fontSize="xl" fontWeight="bold">
        Subscribe to Premium
      </Text>

      <Text fontSize="sm" fontWeight="bold">
        Subscribe to unlock new features and if eligible, receive a share of
        revenue.
      </Text>

      <Button
        bg="blue.primary"
        color="white"
        borderRadius="full"
        fontWeight="bold"
        _hover={{ bg: "blue.primaryHover" }}
        alignSelf="flex-start"
        px="4"
      >
        Subscribe
      </Button>
    </VStack>
  );
};
