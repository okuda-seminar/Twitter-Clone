"use client";

import { SearchIcon } from "@/lib/components/icons";
import { useColorModeValue } from "@/lib/components/ui/color-mode";
import { Tooltip } from "@/lib/components/ui/tooltip";
import {
  Box,
  Button,
  CloseButton,
  Dialog,
  Flex,
  HStack,
  Input,
  InputGroup,
  Text,
} from "@chakra-ui/react";
import type React from "react";
import { useState } from "react";

type NewMessageModalProps = {
  open: boolean;
  onClose: () => void;
};

export const NewMessageModal: React.FC<NewMessageModalProps> = ({
  open,
  onClose,
}) => {
  const bg = useColorModeValue("white", "black");
  const border = useColorModeValue("gray.200", "gray.700");
  const text = useColorModeValue("black", "white");
  const backdropBg = useColorModeValue("backdrop.light", "backdrop.dark");
  const [isFocused, setIsFocused] = useState(false);

  return (
    <Dialog.Root open={open} onInteractOutside={() => onClose()}>
      <Dialog.Backdrop bg={backdropBg} />
      <Dialog.Positioner>
        <Dialog.Content
          bg={bg}
          color={text}
          w="600px"
          maxW="600px"
          h="650px"
          maxH="650px"
          borderRadius="xl"
        >
          <Flex align="center" px="4" py="3" borderColor={border}>
            <Tooltip content="Close">
              <Dialog.CloseTrigger
                asChild
                onClick={onClose}
                position="static"
                borderRadius="full"
                mr="2"
              >
                <CloseButton />
              </Dialog.CloseTrigger>
            </Tooltip>
            <Text ml="2" fontWeight="bold" color={text} fontSize="xl">
              New message
            </Text>
            <Box ml="auto">
              <Button
                size="sm"
                fontWeight="bold"
                borderRadius="full"
                bg={useColorModeValue("gray.900", "gray.200")}
                color={useColorModeValue("white", "black")}
                _hover={{ bg: useColorModeValue("gray.500", "gray.600") }}
                disabled
              >
                Next
              </Button>
            </Box>
          </Flex>
          <Box borderBottomWidth="1px" borderColor={border} px="3" py="2">
            <InputGroup
              startElement={
                <SearchIcon
                  size="sm"
                  color={
                    isFocused
                      ? "blue.primary"
                      : useColorModeValue("gray.600", "gray.400")
                  }
                />
              }
            >
              <Input
                placeholder="Search people"
                bg={useColorModeValue("transparent", "transparent")}
                border="none"
                color={text}
                fontSize="md"
                _placeholder={{ color: useColorModeValue("black", "white") }}
                onFocus={() => setIsFocused(true)}
                onBlur={() => setIsFocused(false)}
                _focus={{ boxShadow: "none", outline: "none", border: "none" }}
                _focusVisible={{
                  boxShadow: "none",
                  outline: "none",
                  border: "none",
                }}
              />
            </InputGroup>
          </Box>
          <Box borderBottomWidth="1px" borderColor={border}>
            <HStack
              px="4"
              py="3"
              gap="3"
              _hover={{ bg: useColorModeValue("gray.100", "gray.900") }}
              transition="background-color 0.2s"
              cursor="pointer"
            >
              <Box
                boxSize="32px"
                borderRadius="full"
                borderWidth="2px"
                borderColor={border}
              />
              <Text color="blue.primary" fontWeight="bold" fontSize="md">
                Create a group
              </Text>
            </HStack>
          </Box>
        </Dialog.Content>
      </Dialog.Positioner>
    </Dialog.Root>
  );
};
