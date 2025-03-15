"use client";

import theme from "@/lib/theme";
import { Button, Divider, Input, Text, VStack } from "@chakra-ui/react";
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
    <VStack as="form" spacing={4} onSubmit={handleNext}>
      <Text fontSize="2xl" fontWeight="bold" textAlign="center">
        Login to X
      </Text>

      <Button
        width="100%"
        bg="white"
        color="black"
        borderRadius="md"
        fontWeight="bold"
        leftIcon={<FaGoogle />}
      >
        Login with Google
      </Button>

      <Button
        width="100%"
        bg="white"
        color="black"
        borderRadius="md"
        fontWeight="bold"
        leftIcon={<FaApple />}
      >
        Login with Apple
      </Button>

      <Divider borderColor="gray" />

      <Text textAlign="center" color="white">
        or
      </Text>

      <Input
        placeholder="Phone, email or username"
        value={username}
        onChange={(e) => handleUsernameChange(e.target.value)}
        bg="black"
        color="white"
        borderColor="gray"
        _placeholder={{ color: "gray" }}
        _focus={{
          borderColor: theme.colors.blue.primary,
        }}
      />

      <Button
        type="submit"
        width="100%"
        bg="white"
        color="black"
        borderRadius="md"
        fontWeight="bold"
        isDisabled={username.trim() === ""}
      >
        Next
      </Button>

      <Text
        textAlign="center"
        color={theme.colors.blue.primary}
        cursor="pointer"
        _hover={{ textDecoration: "underline" }}
      >
        Forgot your password?
      </Text>

      <Text textAlign="center" color="gray">
        Don't have an account?&nbsp;
        <Text
          as="span"
          color={theme.colors.blue.primary}
          cursor="pointer"
          _hover={{ textDecoration: "underline" }}
        >
          Sign up
        </Text>
      </Text>
    </VStack>
  );
};
