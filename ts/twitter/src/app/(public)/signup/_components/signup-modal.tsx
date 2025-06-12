"use client";

import { EyeIcon, SunIcon } from "@/lib/components/icons";
import { VALIDATION_CONSTANTS } from "@/lib/constants/validation-constants";
import {
  Box,
  Button,
  CloseButton,
  Dialog,
  Flex,
  Input,
  Stack,
  Text,
} from "@chakra-ui/react";
import type React from "react";
import { useActionState } from "react";
import { useSignupModal } from "./use-signup-modal";

export const SignupModal: React.FC = () => {
  const {
    formValues,
    showPassword,
    handleInputChange,
    togglePasswordVisibility,
    handleSignupAction,
    isSubmitDisabled,
    handleCloseButtonClick,
  } = useSignupModal();
  const [message, formAction] = useActionState(handleSignupAction, undefined);

  return (
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/759
    // - Fix Sign Up Modal UI Layout and Styling.
    <Dialog.Root open={true} placement="center">
      <Dialog.Backdrop />
      <Dialog.Content
        bg="surface.dark"
        color="white"
        borderRadius="md"
        boxShadow="md"
        border="1px solid"
        borderColor="gray"
        width="400px"
        position="relative"
      >
        <Dialog.CloseTrigger
          asChild
          position="absolute"
          right="auto"
          onClick={handleCloseButtonClick}
          color="gray"
        >
          <CloseButton />
        </Dialog.CloseTrigger>

        <Dialog.Body p="6">
          <form action={formAction}>
            <Stack gap={4}>
              <Flex direction="column" align="center" mb="4">
                <Text
                  fontSize="xl"
                  fontWeight="bold"
                  mb="1"
                  color="blue.primary"
                >
                  Create an account
                </Text>
              </Flex>

              {message !== undefined && (
                <Box
                  bg="error.primary"
                  borderRadius="sm"
                  borderLeft="3px solid"
                  borderColor="red"
                  p={3}
                >
                  <Text color="white">{message}</Text>
                </Box>
              )}

              <Box>
                <Text fontWeight="medium" mb="1">
                  Display Name
                </Text>
                <Input
                  value={formValues.displayName}
                  onChange={(e) =>
                    handleInputChange("displayName", e.target.value)
                  }
                  placeholder="Display name"
                  _placeholder={{ color: "gray" }}
                  name="displayName"
                  bg="black"
                  borderColor="gray"
                />
              </Box>

              <Box>
                <Text fontWeight="medium" mb="1">
                  Username
                </Text>
                <Flex>
                  <Flex
                    align="center"
                    justify="center"
                    bg="black"
                    px="3"
                    borderWidth="1px"
                    borderColor="gray"
                    borderRightWidth="0"
                    borderLeftRadius="md"
                  >
                    @
                  </Flex>
                  <Input
                    value={formValues.username}
                    onChange={(e) =>
                      handleInputChange("username", e.target.value)
                    }
                    placeholder="username"
                    _placeholder={{ color: "gray" }}
                    name="username"
                    maxLength={VALIDATION_CONSTANTS.USERNAME.MAX_LENGTH}
                    bg="black"
                    borderColor="gray"
                    borderLeftRadius="0"
                  />
                </Flex>
                <Text fontSize="xs" color="gray" mt="1">
                  {`Username must be between ${VALIDATION_CONSTANTS.USERNAME.MIN_LENGTH} and ${VALIDATION_CONSTANTS.USERNAME.MAX_LENGTH} characters.`}
                </Text>
              </Box>

              <Box>
                <Text fontWeight="medium" mb="1">
                  Password
                </Text>
                <Flex position="relative">
                  <Input
                    type={showPassword ? "text" : "password"}
                    value={formValues.password}
                    onChange={(e) =>
                      handleInputChange("password", e.target.value)
                    }
                    placeholder="Password"
                    _placeholder={{ color: "gray" }}
                    name="password"
                    maxLength={VALIDATION_CONSTANTS.PASSWORD.MAX_LENGTH}
                    bg="black"
                    borderColor="gray"
                    pr="10"
                  />
                  <Button
                    variant="ghost"
                    onClick={togglePasswordVisibility}
                    title={showPassword ? "Hide password" : "Show password"}
                    position="absolute"
                    right="0"
                    top="0"
                    h="100%"
                    color="gray"
                  >
                    {showPassword ? <SunIcon /> : <EyeIcon />}
                  </Button>
                </Flex>
                <Text fontSize="xs" color="gray" mt="1">
                  {`Password must be between ${VALIDATION_CONSTANTS.PASSWORD.MIN_LENGTH} and ${VALIDATION_CONSTANTS.PASSWORD.MAX_LENGTH} characters.`}
                </Text>
              </Box>

              <Button
                type="submit"
                bg="white"
                color="black"
                borderRadius="md"
                fontWeight="medium"
                mt="2"
                disabled={isSubmitDisabled}
                _hover={{
                  bg: "blue.primaryHover",
                }}
              >
                Register
              </Button>
            </Stack>
          </form>
        </Dialog.Body>
      </Dialog.Content>
    </Dialog.Root>
  );
};
