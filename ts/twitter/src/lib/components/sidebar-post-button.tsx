"use client";

import React from "react";
import NextLink from "next/link";
import { Box, Button, IconButton, Link, Tooltip } from "@chakra-ui/react";
import { FaFeather } from "react-icons/fa";
import { useSession } from "./session-context";

export const SideBarPostButton: React.FC = () => {
  const { session, user } = useSession();

  return (
    <Box>
      <Box display={{ base: "none", xl: "inline" }}>
        {session && user && (
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
        )}
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
