"use client";

import { Box, Button, Input, Text, VStack } from "@chakra-ui/react";
import type React from "react";
import { FaApple, FaGoogle } from "react-icons/fa";

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
      <VStack gap={4} align="stretch" width="100%">
        <Text fontSize="2xl" fontWeight="bold" textAlign="center">
          Login to X
        </Text>
        <Button
          width="100%"
          bg="white"
          color="black"
          borderRadius="full"
          fontWeight="bold"
        >
          <FaGoogle /> Login with Google
        </Button>
        <Button
          width="100%"
          bg="white"
          color="black"
          borderRadius="full"
          fontWeight="bold"
        >
          <FaApple /> Login with Apple
        </Button>
      </VStack>
      <Box position="relative" width="100%" my={2}>
        <Box borderBottom="2px solid" borderColor="gray" width="100%" />
        <Box
          position="absolute"
          top="50%"
          left="50%"
          transform="translate(-50%, -50%)"
          bg="black"
          px={4}
        >
          <Text textAlign="center" color="white">
            or
          </Text>
        </Box>
      </Box>

      <VStack gap={4} align="stretch" width="100%">
        <Input
          placeholder="Phone, email or username"
          value={username}
          onChange={(e) => handleUsernameChange(e.target.value)}
          bg="black"
          color="white"
          borderColor="gray"
          pl="2"
          _placeholder={{ color: "gray" }}
          _focus={{
            borderColor: "blue.primary",
          }}
        />
        <Button
          type="submit"
          width="100%"
          bg="white"
          color="black"
          borderRadius="full"
          fontWeight="bold"
          disabled={username.trim() === ""}
        >
          Next
        </Button>
        <Text
          textAlign="center"
          color="blue.primary"
          cursor="pointer"
          _hover={{ textDecoration: "underline" }}
        >
          Forgot your password?
        </Text>
        <Text textAlign="center" color="gray">
          Don't have an account?&nbsp;
          <Text
            as="span"
            color="blue.primary"
            cursor="pointer"
            _hover={{ textDecoration: "underline" }}
          >
            Sign up
          </Text>
        </Text>
      </VStack>
    </VStack>
  );
};
