"use client";

import { BackIcon, SearchIcon } from "@/lib/components/icons";
import { useColorModeValue } from "@/lib/components/ui/color-mode";
import { Tooltip } from "@/lib/components/ui/tooltip";
import {
  Box,
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
      <Box>
        <Box width="100%" padding="0">
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

            <VStack align="flex-start">
              <Text fontSize="xl" fontWeight="bold">
                Bookmarks
              </Text>
            </VStack>
          </Flex>
        </Box>
      </Box>

      <VStack py={8} px={4} align="center">
        <InputGroup startElement={<SearchIcon size="sm" />}>
          <Input borderRadius="full" placeholder="Search" />
        </InputGroup>

        <Text fontWeight="bold" fontSize="2xl" textAlign="center">
          Save posts for later
        </Text>

        <Text fontSize="md" color="gray.600" textAlign="center">
          Bookmark posts to easily find them again in the future.
        </Text>
      </VStack>
    </VStack>
  );
};
