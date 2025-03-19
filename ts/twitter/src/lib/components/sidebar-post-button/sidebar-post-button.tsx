"use client";

import { Box, Button, Link as ChakraLink, IconButton } from "@chakra-ui/react";
import NextLink from "next/link";
import type React from "react";
import { FaFeather } from "react-icons/fa";
import { useSession } from "../session-context";
import { Tooltip } from "../ui/tooltip";

export const SideBarPostButton: React.FC = () => {
  const { session, user } = useSession();

  return (
    <Box>
      <Box display={{ base: "none", xl: "inline" }}>
        {session && user && (
          <ChakraLink asChild>
            <NextLink href="/compose/post" scroll={false}>
              <Button
                bg="blue.primary"
                color="white"
                width="200px"
                size="lg"
                borderRadius="full"
              >
                Post
              </Button>
            </NextLink>
          </ChakraLink>
        )}
      </Box>
      <Tooltip content="Post" positioning={{ placement: "bottom" }}>
        <Box display={{ base: "inline", xl: "none" }}>
          <ChakraLink asChild>
            <NextLink href="/compose/post" scroll={false}>
              <IconButton
                bg="blue.primary"
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
