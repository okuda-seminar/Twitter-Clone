"use client";

import type { LoginBody } from "@/lib/actions/login";
import { BackIcon, XIcon } from "@/lib/components/icons";
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
    <Box position="relative" height="100%" minHeight="500px">
      <form action={formAction}>
        <Box width="100%" position="relative" mb={2}>
          <Button
            variant="ghost"
            size="md"
            onClick={handleBackButtonClick}
            position="absolute"
            left={-4}
            top={-6}
            _hover={{ color: useColorModeValue("black", "white") }}
            aria-label="Back to account"
          >
            <BackIcon /> Back
          </Button>
        </Box>
        <VStack align="center" height="100%">
          <VStack gap={8} align="stretch" width="80%">
            <IconButton
              aria-label="X"
              width="36px"
              alignSelf="center"
              color={useColorModeValue("black", "white")}
              bg={useColorModeValue("white", "black")}
              mt={-6}
            >
              <XIcon boxSize={8} />
            </IconButton>

            <Text fontSize="3xl" fontWeight="bold" textAlign="left">
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
            <Field.Root>
              <Box pos="relative" w="full">
                <Input
                  name="username"
                  placeholder=" "
                  className="peer"
                  fontSize="lg"
                  value={loginFormValue.username}
                  readOnly
                  bg={useColorModeValue("gray.100", "gray.900")}
                  color={useColorModeValue("black", "gray.500")}
                  pl="2"
                  pt="4"
                  width="100%"
                  height="60px"
                  _placeholder={{ color: "gray" }}
                  _focus={{ borderColor: "blue.primary" }}
                />
                <Field.Label css={floatingStyles()}>Username</Field.Label>
              </Box>
            </Field.Root>

            <Field.Root>
              <Box pos="relative" w="full">
                <Input
                  name="password"
                  type="password"
                  placeholder=" "
                  className="peer"
                  value={loginFormValue.password}
                  onChange={(e) => handlePasswordChange(e.target.value)}
                  bg={useColorModeValue("gray.100", "black")}
                  color={useColorModeValue("black", "white")}
                  borderColor={useColorModeValue("gray.200", "gray")}
                  pl="2"
                  pt="4"
                  width="100%"
                  height="60px"
                  _placeholder={{ color: "gray" }}
                  _focus={{ borderColor: "blue.primary" }}
                />
                <Field.Label css={floatingStyles()}>Password</Field.Label>
              </Box>
            </Field.Root>

            <Text
              color={"blue.primary"}
              fontSize="sm"
              textAlign="left"
              width="100%"
              mt="-30px"
              cursor="pointer"
              _hover={{ textDecoration: "underline" }}
            >
              Forgot password?
            </Text>
          </VStack>
          <VStack
            gap={4}
            align="stretch"
            width="80%"
            position="absolute"
            bottom="20px"
          >
            <Button
              type="submit"
              width="100%"
              height="50px"
              bg={useColorModeValue("black", "white")}
              color={useColorModeValue("white", "black")}
              borderRadius="full"
              fontWeight="bold"
              fontSize="md"
              disabled={loginFormValue.password.trim() === ""}
            >
              Log in
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
      </form>
    </Box>
  );
};
