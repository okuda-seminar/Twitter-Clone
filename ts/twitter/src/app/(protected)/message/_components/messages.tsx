"use client";

import { CreateMailIcon, SettingsIcon } from "@/lib/components/icons";
import { useColorModeValue } from "@/lib/components/ui/color-mode";
import { Tooltip } from "@/lib/components/ui/tooltip";
import {
  Box,
  Button,
  Link as ChakraLink,
  Flex,
  IconButton,
  Spacer,
  Text,
  VStack,
} from "@chakra-ui/react";
import NextLink from "next/link";
import { useRouter } from "next/navigation";
import type React from "react";

export const Messages: React.FC = () => {
  const router = useRouter();
  return (
    <VStack align="stretch">
      <Box divideY="1px">
        <Box width="100%" padding="0">
          <Flex mx="4px" gap="4" align="center">
            <Text fontSize="xl" fontWeight="bold">
              Messages
            </Text>
            <Spacer />
            <Flex mx="4px" gap="0" align="center">
              <Tooltip
                content="Settings"
                contentProps={{
                  style: {
                    backgroundColor: useColorModeValue("gray.800", "gray"),
                    color: "white",
                  },
                }}
              >
                <IconButton
                  my="5px"
                  bg="transparent"
                  borderRadius="full"
                  color={useColorModeValue("black", "white")}
                  _hover={{ bg: useColorModeValue("gray.200", "gray.900") }}
                >
                  <SettingsIcon />
                </IconButton>
              </Tooltip>
              <Tooltip
                content="Create Message"
                contentProps={{
                  style: {
                    backgroundColor: useColorModeValue("gray.800", "gray"),
                    color: "white",
                  },
                }}
              >
                <IconButton
                  my="5px"
                  bg="transparent"
                  borderRadius="full"
                  color={useColorModeValue("black", "white")}
                  _hover={{ bg: useColorModeValue("gray.200", "gray.900") }}
                  onClick={() => router.push("/message/compose")}
                >
                  <CreateMailIcon />
                </IconButton>
              </Tooltip>
            </Flex>
          </Flex>
        </Box>
        <Box
          minHeight="600px"
          display="flex"
          alignItems="center"
          justifyContent="center"
        >
          <VStack gap="6" maxW="400px" px="4">
            <Text
              fontSize="4xl"
              fontWeight="bold"
              color={useColorModeValue("black", "white")}
              lineHeight="1.2"
              textAlign="left"
            >
              Welcome to your inbox!
            </Text>

            <Text
              fontSize="md"
              color={useColorModeValue("gray.600", "gray.400")}
              lineHeight="1.5"
              textAlign="left"
            >
              Drop a line, share posts and more with private conversations
              between you and others on X.
            </Text>

            <Box alignSelf="flex-start">
              <ChakraLink asChild _hover={{ textDecoration: "none" }}>
                <NextLink href="/message/compose" scroll={false}>
                  <Button
                    bg="blue.primary"
                    color="white"
                    size="lg"
                    borderRadius="full"
                    px="8"
                    py="6"
                    fontSize="md"
                    fontWeight="bold"
                    _hover={{
                      bg: "blue.primaryHover",
                    }}
                    transition="all 0.2s"
                  >
                    Write a message
                  </Button>
                </NextLink>
              </ChakraLink>
            </Box>
          </VStack>
        </Box>
      </Box>
    </VStack>
  );
};
