"use client";

import { Box, Button, Link as ChakraLink, IconButton } from "@chakra-ui/react";
import NextLink from "next/link";
import type React from "react";
import { FaFeather } from "react-icons/fa";
import { useAuth } from "../auth-context";
import { useColorModeValue } from "../ui/color-mode";
import { Tooltip } from "../ui/tooltip";

export const SideBarPostButton: React.FC = () => {
  const { user } = useAuth();
  const bgColor = useColorModeValue("black", "white");
  const textColor = useColorModeValue("white", "black");

  if (!user) {
    return null;
  }

  return (
    <Box>
      <Box display={{ base: "none", xl: "inline" }}>
        <ChakraLink asChild>
          <NextLink href="/compose/post" scroll={false}>
            <Button
              bg={bgColor}
              color={textColor}
              width="200px"
              size="lg"
              borderRadius="full"
            >
              Post
            </Button>
          </NextLink>
        </ChakraLink>
      </Box>
      <Tooltip content="Post" positioning={{ placement: "bottom" }}>
        <Box display={{ base: "inline", xl: "none" }}>
          <ChakraLink asChild>
            <NextLink href="/compose/post" scroll={false}>
              <IconButton
                bg={bgColor}
                aria-label={"Post"}
                mx={3}
                borderRadius="full"
              >
                <FaFeather />
              </IconButton>
            </NextLink>
          </ChakraLink>
        </Box>
      </Tooltip>
    </Box>
  );
};
