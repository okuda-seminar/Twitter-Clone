"use client";

import theme from "@/lib/theme";
import { Button, Input, Text, VStack } from "@chakra-ui/react";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { login } from "#src/lib/actions/login";

interface PasswordModalProps {
  username: string;
}

export const PasswordModal: React.FC<PasswordModalProps> = ({ username }) => {
  const router = useRouter();
  const [password, setPassword] = useState("");

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    const result = await login({ username, password });
    if (result.ok === true) {
      router.push("/home");
    } else {
      alert(`Login failed: ${result.error.statusText}`);
    }
  };

  return (
    <VStack spacing={4} as="form" onSubmit={handleLogin}>
      <Text fontSize="2xl" fontWeight="bold" textAlign="center">
        Enter your password
      </Text>

      {/* Display username (read-only) */}
      <Input
        value={username}
        isDisabled
        bg="black"
        color="white"
        borderColor="gray"
        _placeholder={{ color: "gray" }}
        _focus={{
          borderColor: theme.colors.blue.secondary,
        }}
      />

      {/* Password input */}
      <Input
        placeholder="Password"
        type="password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        bg="black"
        color="white"
        borderColor="gray"
        _placeholder={{ color: "gray" }}
        _focus={{
          borderColor: theme.colors.blue.secondary,
        }}
      />

      <Text
        color={theme.colors.blue.secondary}
        textAlign="center"
        _hover={{ textDecoration: "underline", cursor: "pointer" }}
      >
        Forgot your password?
      </Text>

      <Button
        type="submit"
        width="100%"
        bg="white"
        color="black"
        borderRadius="md"
        fontWeight="bold"
        isDisabled={!password}
      >
        Login
      </Button>

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
