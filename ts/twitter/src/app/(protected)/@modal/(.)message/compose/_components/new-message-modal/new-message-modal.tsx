"use client";

import { SearchIcon } from "@/lib/components/icons";
import { useColorModeValue } from "@/lib/components/ui/color-mode";
import { Tooltip } from "@/lib/components/ui/tooltip";
import { UI_CONSTANTS } from "@/lib/constants/ui-constants";
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
import { useEffect, useState } from "react";

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
  const hoverBg = useColorModeValue("gray.100", "gray.800");
  const groupHoverBg = useColorModeValue("gray.100", "gray.900");
  const buttonBg = useColorModeValue("gray.900", "gray.200");
  const buttonText = useColorModeValue("white", "black");
  const buttonHoverBg = useColorModeValue("gray.500", "gray.600");
  const placeholderColor = useColorModeValue("gray.500", "gray.400");
  const iconColor = useColorModeValue("gray.600", "gray.400");
  const [isFocused, setIsFocused] = useState(false);
  const [isMobile, setIsMobile] = useState(false);

  useEffect(() => {
    const checkScreenSize = () => {
      setIsMobile(window.innerWidth <= UI_CONSTANTS.BREAKPOINTS.MOBILE);
    };

    checkScreenSize();

    window.addEventListener("resize", checkScreenSize);

    return () => {
      window.removeEventListener("resize", checkScreenSize);
    };
  }, []);

  return (
    <Dialog.Root open={open} onInteractOutside={() => onClose()}>
      <Dialog.Backdrop bg={isMobile ? "transparent" : backdropBg} />
      <Dialog.Positioner>
        <Dialog.Content
          bg={bg}
          color={text}
          w={isMobile ? "100vw" : "600px"}
          maxW={isMobile ? "100vw" : "600px"}
          h={isMobile ? "100vh" : "650px"}
          maxH={isMobile ? "100vh" : "650px"}
          borderRadius={isMobile ? "0" : "xl"}
          m={isMobile ? "0" : "auto"}
          position={isMobile ? "fixed" : "relative"}
          top={isMobile ? "0" : "auto"}
          left={isMobile ? "0" : "auto"}
          right={isMobile ? "0" : "auto"}
          bottom={isMobile ? "0" : "auto"}
          zIndex={isMobile ? "modal" : "auto"}
          overflow="auto"
        >
          <Flex
            align="center"
            px="4"
            py="3"
            borderBottomWidth="1px"
            borderColor={border}
            position={isMobile ? "sticky" : "static"}
            top={isMobile ? "0" : "auto"}
            bg={bg}
            zIndex={isMobile ? "1" : "auto"}
          >
            <Tooltip content="Close">
              <Dialog.CloseTrigger
                asChild
                onClick={onClose}
                position="static"
                borderRadius="full"
                mr="2"
                _hover={{ bg: hoverBg }}
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
                bg={buttonBg}
                color={buttonText}
                _hover={{ bg: buttonHoverBg }}
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
                  color={isFocused ? "blue.primary" : iconColor}
                />
              }
            >
              <Input
                placeholder="Search people"
                bg="transparent"
                border="none"
                color={text}
                fontSize="md"
                _placeholder={{
                  color: placeholderColor,
                }}
                onFocus={() => setIsFocused(true)}
                onBlur={() => setIsFocused(false)}
                _focus={{
                  boxShadow: "none",
                  outline: "none",
                  border: "none",
                }}
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
              _hover={{ bg: groupHoverBg }}
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
