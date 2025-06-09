"use client";

import {
  BackIcon,
  CreateCommunityIcon,
  SearchIcon,
} from "@/lib/components/icons";
import { useColorModeValue } from "@/lib/components/ui/color-mode";
import { Tooltip } from "@/lib/components/ui/tooltip";
import {
  Box,
  Link as ChakraLink,
  Flex,
  IconButton,
  Spacer,
  Text,
  VStack,
} from "@chakra-ui/react";
import NextLink from "next/link";
import type React from "react";

export const Communities: React.FC = () => {
  return (
    <VStack align="stretch">
      <Box divideY="1px">
        <Box width="100%" padding="0">
          <Flex mx="4px" gap="4" align="center">
            <Tooltip
              content="Back"
              contentProps={{
                style: {
                  backgroundColor: useColorModeValue("gray.800", "gray"),
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
                    color={useColorModeValue("black", "white")}
                    _hover={{ bg: useColorModeValue("gray.200", "gray.900") }}
                  >
                    <BackIcon />
                  </IconButton>
                </NextLink>
              </ChakraLink>
            </Tooltip>
            <Text fontSize="xl" fontWeight="bold">
              Communities
            </Text>
            <Spacer />
            <Flex mx="4px" gap="0" align="center">
              <IconButton
                my="5px"
                bg="transparent"
                borderRadius="full"
                color={useColorModeValue("black", "white")}
                _hover={{ bg: useColorModeValue("blue.100", "gray.900") }}
              >
                <SearchIcon />
              </IconButton>
              <IconButton
                my="5px"
                bg="transparent"
                borderRadius="full"
                color={useColorModeValue("black", "white")}
                _hover={{ bg: useColorModeValue("blue.100", "gray.900") }}
              >
                <CreateCommunityIcon />
              </IconButton>
            </Flex>
          </Flex>
        </Box>
        <Box>Posts</Box>
      </Box>
    </VStack>
  );
};
