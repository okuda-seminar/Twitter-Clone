"use client";

import {
  ChevronRightIcon,
  ExternalLinkIcon,
  SearchIcon,
} from "@/lib/components/icons";
import { useColorModeValue } from "@/lib/components/ui/color-mode";
import { Flex, Input, InputGroup, Text, VStack } from "@chakra-ui/react";
import type React from "react";

export const Settings: React.FC = () => {
  const items = [
    {
      label: "Your Account",
      icon: <ChevronRightIcon boxSize="18.75px" />,
    },
    {
      label: "Monetization",
      icon: <ChevronRightIcon boxSize="18.75px" />,
    },
    {
      label: "Premium",
      icon: <ChevronRightIcon boxSize="18.75px" />,
    },
    {
      label: "Creator Subscriptions",
      icon: <ChevronRightIcon boxSize="18.75px" />,
    },
    {
      label: "Security and account access",
      icon: <ChevronRightIcon boxSize="18.75px" />,
    },
    {
      label: "Privacy and safety",
      icon: <ChevronRightIcon boxSize="18.75px" />,
    },
    {
      label: "Notifications",
      icon: <ChevronRightIcon boxSize="18.75px" />,
    },
    {
      label: "Accessibility, display, and languages",
      icon: <ChevronRightIcon boxSize="18.75px" />,
    },
    {
      label: "Additional resources",
      icon: <ChevronRightIcon boxSize="18.75px" />,
    },
    {
      label: "Help Center",
      icon: <ExternalLinkIcon boxSize="18.75px" />,
    },
  ];
  return (
    <VStack align="stretch" p="16px">
      <Text fontSize="xl" fontWeight="bold">
        Settings
      </Text>
      {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/777
        - Resize search bar in settings tab
       */}
      <InputGroup startElement={<SearchIcon size="sm" />} p="8px">
        <Input
          placeholder="Search Settings"
          borderRadius="full"
          _placeholder={{ color: useColorModeValue("black", "white") }}
        />
      </InputGroup>
      <Flex
        direction="column"
        width="100%"
        bg={useColorModeValue("white", "black")}
      >
        {items.map((item) => (
          <Flex
            key={item.label}
            alignItems="center"
            justifyContent="space-between"
            p="12px"
            _hover={{ bg: useColorModeValue("gray.100", "gray.700") }}
            cursor="pointer"
          >
            <Text fontWeight="medium">{item.label}</Text>
            {item.icon}
          </Flex>
        ))}
      </Flex>
    </VStack>
  );
};
