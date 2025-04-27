"use client";

import type { LoginBody } from "@/lib/actions/login";
import { BackIcon } from "@/lib/components/icons";
import { useColorModeValue } from "@/lib/components/ui/color-mode";
import { Box, Button, Input, Text, VStack } from "@chakra-ui/react";
import { useActionState } from "react";
import { usePasswordModal } from "./use-password-modal";

interface PasswordModalProps {
  loginFormValue: LoginBody;
  handleBackButtonClick: () => void;
  handlePasswordChange: (password: string) => void;
}

export const PasswordModal: React.FC<PasswordModalProps> = ({
  loginFormValue,
  handleBackButtonClick,
  handlePasswordChange,
}) => {
  const { handleLoginAction } = usePasswordModal();
  const [message, formAction] = useActionState(handleLoginAction, undefined);

  return (
    <form action={formAction}>
      <VStack gap={4}>
        <Box width="100%" position="relative" mb={4}>
          <Button
            variant="ghost"
            size="sm"
            onClick={handleBackButtonClick}
            position="absolute"
            left={0}
            top={0}
            _hover={{ color: "white" }}
            aria-label="Back to account"
          >
            <BackIcon /> Back
          </Button>
        </Box>

        <Text fontSize="2xl" fontWeight="bold" textAlign="center">
          Enter your password
        </Text>

        {message !== undefined && (
          <Text
            fontSize="14px"
            lineHeight="16px"
            px="16px"
            py="12px"
            bg="error.primary"
            borderRadius="8px"
            color="white"
          >
            {message}
          </Text>
        )}

        <Input
          name="username"
          value={loginFormValue.username}
          readOnly
          bg={useColorModeValue("gray.100", "gray.900")}
          color={useColorModeValue("black", "gray.500")}
          pl="2"
          _placeholder={{ color: "gray" }}
          _focus={{ borderColor: "blue.primary" }}
        />

        <Input
          name="password"
          placeholder="Password"
          type="password"
          value={loginFormValue.password}
          onChange={(e) => handlePasswordChange(e.target.value)}
          bg={useColorModeValue("gray.100", "black")}
          color={useColorModeValue("black", "white")}
          borderColor={useColorModeValue("gray.200", "gray")}
          pl="2"
          _placeholder={{ color: "gray" }}
          _focus={{ borderColor: "blue.primary" }}
        />

        <Text
          color={"blue.primary"}
          textAlign="center"
          cursor="pointer"
          _hover={{ textDecoration: "underline" }}
        >
          Forgot your password?
        </Text>

        <Button
          type="submit"
          width="100%"
          bg={useColorModeValue("black", "white")}
          color={useColorModeValue("white", "black")}
          borderRadius="full"
          fontWeight="bold"
          disabled={loginFormValue.password.trim() === ""}
        >
          Login
        </Button>

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
    </form>
  );
};
