"use client";

import { AppleIcon, GoogleIcon, XIcon } from "@/lib/components/icons";
import { useColorModeValue } from "@/lib/components/ui/color-mode";
import { floatingStyles } from "@/lib/styles/floating-labels";
import {
  Box,
  Button,
  Field,
  IconButton,
  Input,
  Text,
  VStack,
} from "@chakra-ui/react";
import { Link as ChakraLink } from "@chakra-ui/react";
import NextLink from "next/link";
import type React from "react";

interface AccountModalProps {
  username: string;
  handleNextButtonClick: () => void;
  handleUsernameChange: (username: string) => void;
}

export const AccountModal: React.FC<AccountModalProps> = ({
  username,
  handleNextButtonClick,
  handleUsernameChange,
}) => {
  const handleNext = (e: React.FormEvent) => {
    e.preventDefault();
    handleNextButtonClick();
  };

  return (
    <VStack as="form" gap={4} onSubmit={handleNext}>
      <IconButton
        aria-label="X"
        width="36px"
        color={useColorModeValue("black", "white")}
        bg={useColorModeValue("white", "black")}
        mt={-4}
      >
        <XIcon boxSize={8} />
      </IconButton>
      <VStack gap={8} align="stretch" width="55%">
        <Text fontSize="3xl" fontWeight="bold" textAlign="left">
          Sign in to X
        </Text>
        <Button
          width="100%"
          bg="white"
          color="black"
          borderRadius="full"
          fontWeight="bold"
          boxShadow="0 0 0 1px gray"
        >
          <GoogleIcon /> Login with Google
        </Button>
        <Button
          width="100%"
          bg="white"
          color="black"
          borderRadius="full"
          fontWeight="bold"
          boxShadow="0 0 0 1px gray"
        >
          <AppleIcon /> Login with Apple
        </Button>
      </VStack>
      <Box position="relative" width="55%" my={2}>
        <Box borderBottom="2px solid" borderColor="gray" width="100%" />
        <Box
          position="absolute"
          top="50%"
          left="50%"
          transform="translate(-50%, -50%)"
          bg={useColorModeValue("white", "black")}
          px={4}
        >
          <Text textAlign="center" color={useColorModeValue("black", "white")}>
            or
          </Text>
        </Box>
      </Box>

      <VStack gap={8} align="stretch" width="55%">
        <Field.Root>
          <Box pos="relative" w="full">
            <Input
              placeholder=" "
              value={username}
              className="peer"
              onChange={(e) => handleUsernameChange(e.target.value)}
              bg={useColorModeValue("white", "black")}
              color={useColorModeValue("black", "white")}
              borderColor="gray"
              pl="2"
              pt="3"
              height="60px"
              _placeholder={{ color: "gray" }}
              _focus={{
                borderColor: "blue.primary",
              }}
            />
            <Field.Label css={floatingStyles()}>
              Phone, email or username
            </Field.Label>
          </Box>
        </Field.Root>
        <Button
          type="submit"
          width="100%"
          bg={useColorModeValue("black", "white")}
          color={useColorModeValue("white", "black")}
          borderRadius="full"
          fontWeight="bold"
          disabled={username.trim() === ""}
        >
          Next
        </Button>
        <Button
          type="submit"
          width="100%"
          bg={useColorModeValue("white", "black")}
          color={useColorModeValue("black", "white")}
          borderRadius="full"
          fontWeight="bold"
          boxShadow="0 0 0 1px gray"
        >
          Forgot password?
        </Button>
        <Text textAlign="left" color="gray">
          Don't have an account?&nbsp;
          <ChakraLink asChild>
            <NextLink href="/signup">
              <Text
                as="span"
                color="blue.primary"
                cursor="pointer"
                _hover={{ textDecoration: "underline" }}
              >
                Sign up
              </Text>
            </NextLink>
          </ChakraLink>
        </Text>
      </VStack>
    </VStack>
  );
};
