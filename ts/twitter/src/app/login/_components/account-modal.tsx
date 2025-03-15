"use client";

import theme from "@/lib/theme";
import { Button, Divider, Input, Text, VStack } from "@chakra-ui/react";
import { useState } from "react";
import type React from "react";
import { FaApple, FaGoogle } from "react-icons/fa";

interface AccountModalProps {
  onNext: (username: string) => void;
}

export const AccountModal: React.FC<AccountModalProps> = ({ onNext }) => {
  const [username, setUsername] = useState("");

  const handleNext = (e: React.FormEvent) => {
    e.preventDefault();
    if (username.trim() !== "") {
      onNext(username);
    } else {
      alert("Please enter a username.");
    }
  };

  return (
    <VStack spacing={4} as="form" onSubmit={handleNext}>
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
        placeholder="Phone number / Email address / Username"
        value={username}
        onChange={(e) => setUsername(e.target.value)}
        bg="black"
        color="white"
        borderColor="gray"
        _placeholder={{ color: "gray" }}
        _focus={{
          borderColor: theme.colors.blue.secondary,
        }}
      />

      <Button
        type="submit"
        width="100%"
        bg="white"
        color="black"
        borderRadius="md"
        fontWeight="bold"
      >
        Next
      </Button>

      <Text
        textAlign="center"
        color={theme.colors.blue.secondary}
        _hover={{ textDecoration: "underline", cursor: "pointer" }}
      >
        Forgot your password?
      </Text>

      <Text textAlign="center" color="gray">
        Don't have an account?{" "}
        <Text
          as="span"
          color={theme.colors.blue.secondary}
          _hover={{ textDecoration: "underline", cursor: "pointer" }}
        >
          Sign up
        </Text>
      </Text>
    </VStack>
  );
};
