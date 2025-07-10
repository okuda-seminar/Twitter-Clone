"use client";

import { BackIcon, SearchIcon } from "@/lib/components/icons";
import { useColorModeValue } from "@/lib/components/ui/color-mode";
import { Tooltip } from "@/lib/components/ui/tooltip";
import {
  Link as ChakraLink,
  Flex,
  IconButton,
  Input,
  InputGroup,
  Text,
  VStack,
} from "@chakra-ui/react";
import NextLink from "next/link";
import type React from "react";

export const Bookmarks: React.FC = () => {
  const iconButtonHoverBg = useColorModeValue("gray.200", "gray.900");
  const iconColor = useColorModeValue("black", "white");
  const tooltipBg = useColorModeValue("gray.800", "gray");

  return (
    <VStack align="stretch">
      <Flex mx="4px" gap="4" align="center">
        <Tooltip
          content="Back"
          contentProps={{
            style: {
              backgroundColor: tooltipBg,
              color: "white",
            },
          }}
        >
          <ChakraLink asChild>
            <NextLink href="/home" scroll={false}>
              <IconButton
                my="5px"
                bg="transparent"
                borderRadius="full"
                color={iconColor}
                _hover={{ bg: iconButtonHoverBg }}
                aria-label="Back"
              >
                <BackIcon />
              </IconButton>
            </NextLink>
          </ChakraLink>
        </Tooltip>

        <Text fontSize="xl" fontWeight="bold">
          Bookmarks
        </Text>
      </Flex>

      <VStack px="4" align="center">
        <InputGroup startElement={<SearchIcon size="sm" />}>
          <Input borderRadius="full" placeholder="Search Bookmarks" />
        </InputGroup>

        <VStack mt="8" maxWidth="360px" align="flex-start">
          <Text fontWeight="bold" fontSize="3xl" textAlign="left">
            Save posts for later
          </Text>

          <Text fontSize="md" color="gray.500" textAlign="left">
            Bookmark posts to easily find them again in the future.
          </Text>
        </VStack>
      </VStack>
    </VStack>
  );
};
