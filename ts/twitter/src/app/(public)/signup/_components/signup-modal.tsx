"use client";

import { EyeIcon, EyeSlashIcon, XIcon } from "@/lib/components/icons";
import { useColorModeValue } from "@/lib/components/ui/color-mode";
import { Tooltip } from "@/lib/components/ui/tooltip";
import { VALIDATION_CONSTANTS } from "@/lib/constants/validation-constants";
import {
  Box,
  Button,
  CloseButton,
  Dialog,
  Flex,
  IconButton,
  Input,
  Text,
  VStack,
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
    <Flex align="center" justify="center">
      <Dialog.Root open={true}>
        <Dialog.Backdrop />
        <Dialog.Content
          bg={useColorModeValue("white", "black")}
          color={useColorModeValue("black", "white")}
          borderRadius="2xl"
          boxShadow="md"
          border="1px solid"
          borderColor="gray"
          maxWidth="600px"
          width="600px"
          height="650px"
          position="relative"
        >
          <Tooltip content="Back">
            <Dialog.CloseTrigger
              asChild
              position="absolute"
              borderRadius="full"
              right="auto"
              left="1"
              onClick={handleCloseButtonClick}
              color={useColorModeValue("black", "white")}
            >
              <CloseButton />
            </Dialog.CloseTrigger>
          </Tooltip>

          <Dialog.Body p="6">
            <form action={formAction}>
              <VStack gap={6} align="center">
                <Box position="center">
                  <XIcon boxSize={8} />
                </Box>
                <VStack gap={4} align="stretch" width="85%">
                  <Text
                    fontSize="3xl"
                    fontWeight="bold"
                    mb="1"
                    color={useColorModeValue("black", "white")}
                  >
                    Create your account
                  </Text>

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
                      fontSize="md"
                      name="displayName"
                      bg={useColorModeValue("white", "black")}
                      borderColor="gray"
                      height="60px"
                      width="100%"
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
                        bg={useColorModeValue("white", "black")}
                        px="3"
                        borderWidth="1px"
                        borderColor="gray"
                        borderRightWidth="0"
                        borderLeftRadius="md"
                        fontSize="md"
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
                        fontSize="md"
                        name="username"
                        maxLength={VALIDATION_CONSTANTS.USERNAME.MAX_LENGTH}
                        bg={useColorModeValue("white", "black")}
                        borderColor="gray"
                        borderLeftRadius="0"
                        height="60px"
                        width="100%"
                      />
                    </Flex>
                    <Text fontSize="sm" color="gray" mt="1">
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
                        fontSize="md"
                        name="password"
                        maxLength={VALIDATION_CONSTANTS.PASSWORD.MAX_LENGTH}
                        bg={useColorModeValue("white", "black")}
                        borderColor="gray"
                        height="60px"
                        width="100%"
                      />
                      <IconButton
                        variant="ghost"
                        onClick={togglePasswordVisibility}
                        title={showPassword ? "Hide password" : "Show password"}
                        position="absolute"
                        borderRadius="full"
                        size="sm"
                        right="2"
                        top="3"
                        color="gray"
                        bg={useColorModeValue("white", "black")}
                        _hover={{
                          bg: useColorModeValue("gray.300", "gray.700"),
                        }}
                      >
                        {showPassword ? (
                          <EyeSlashIcon boxSize={5} />
                        ) : (
                          <EyeIcon boxSize={5} />
                        )}
                      </IconButton>
                    </Flex>
                    <Text fontSize="sm" color="gray" mt="1">
                      {`Password must be between ${VALIDATION_CONSTANTS.PASSWORD.MIN_LENGTH} and ${VALIDATION_CONSTANTS.PASSWORD.MAX_LENGTH} characters.`}
                    </Text>
                  </Box>
                </VStack>
                <VStack
                  gap={4}
                  align="center"
                  width="80%"
                  position="absolute"
                  bottom="30px"
                >
                  <Button
                    type="submit"
                    bg={useColorModeValue("black", "white")}
                    color={useColorModeValue("white", "black")}
                    borderRadius="full"
                    fontWeight="bold"
                    fontSize="lg"
                    disabled={isSubmitDisabled}
                    _hover={{
                      bg: "blue.primaryHover",
                    }}
                    height="55px"
                    width="100%"
                  >
                    Register
                  </Button>
                </VStack>
              </VStack>
            </form>
          </Dialog.Body>
        </Dialog.Content>
      </Dialog.Root>
    </Flex>
  );
};
