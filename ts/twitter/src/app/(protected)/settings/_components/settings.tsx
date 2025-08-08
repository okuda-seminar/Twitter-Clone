"use client";

import {
  BackIcon,
  ChevronRightIcon,
  ExternalLinkIcon,
  SearchIcon,
} from "@/lib/components/icons";
import { useColorModeValue } from "@/lib/components/ui/color-mode";
import {
  Flex,
  IconButton,
  Input,
  InputGroup,
  Text,
  VStack,
} from "@chakra-ui/react";
import type React from "react";
import { useState } from "react";

export const Settings: React.FC = () => {
  const [isFocused, setIsFocused] = useState<boolean>(false);

  // Call hooks outside of conditions to define icon and hover state colors.
  const primaryColor = useColorModeValue("black", "white");
  const hoverBg = useColorModeValue("gray.100", "gray.900");
  const listBg = useColorModeValue("white", "black");

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

  const handleBackClick = () => {
    setIsFocused(false);
  };

  return (
    <VStack align="stretch" p="16px">
      <Text fontSize="xl" fontWeight="bold">
        Settings
      </Text>
      <Flex>
        {isFocused && (
          <IconButton
            mt="8px"
            bg="transparent"
            borderRadius="full"
            color={primaryColor}
            _hover={{ bg: hoverBg }}
            onClick={handleBackClick}
          >
            <BackIcon />
          </IconButton>
        )}
        <InputGroup startElement={<SearchIcon size="sm" />} p="8px">
          <Input
            placeholder="Search Settings"
            borderRadius="full"
            _focus={{ borderColor: "blue.500" }}
            _placeholder={{ color: primaryColor }}
            onFocus={() => setIsFocused(true)}
          />
        </InputGroup>
      </Flex>

      {isFocused ? (
        <Text
          mt="5"
          fontSize="sm"
          textAlign="center"
          color="gray"
          fontWeight="medium"
        >
          Try searching for notifications, privacy, etc.
        </Text>
      ) : (
        <Flex direction="column" width="100%" bg={listBg}>
          {items.map((item) => (
            <Flex
              key={item.label}
              alignItems="center"
              justifyContent="space-between"
              p="12px"
              _hover={{ bg: hoverBg }}
              cursor="pointer"
            >
              <Text fontWeight="medium">{item.label}</Text>
              {item.icon}
            </Flex>
          ))}
        </Flex>
      )}
    </VStack>
  );
};
