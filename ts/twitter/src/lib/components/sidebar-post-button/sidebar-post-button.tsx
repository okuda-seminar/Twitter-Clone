"use client";

import { Box, Button, IconButton, Link, Tooltip } from "@chakra-ui/react";
import NextLink from "next/link";
import type React from "react";
import { FaFeather } from "react-icons/fa";
import { useAuth } from "../auth-context";

export const SideBarPostButton: React.FC = () => {
  const { user } = useAuth();

  if (!user) {
    return null;
  }

  return (
    <Box>
      <Box display={{ base: "none", xl: "inline" }}>
        <Link as={NextLink} href="/compose/post" scroll={false}>
          <Button
            bg="blue.primary"
            color="white"
            width="200px"
            size="lg"
            borderRadius="full"
          >
            Post
          </Button>
        </Link>
      </Box>

      <Tooltip label={"Post"} placement="bottom">
        <Box display={{ base: "inline", xl: "none" }}>
          <Link as={NextLink} href="/compose/post" scroll={false}>
            <IconButton
              bg="blue.primary"
              aria-label={"Post"}
              icon={<FaFeather />}
              mx={4}
              borderRadius="full"
            />
          </Link>
        </Box>
      </Tooltip>
    </Box>
  );
};
