"use client";

import { Box, Button, IconButton } from "@chakra-ui/react";
import type React from "react";
import { CiLogin } from "react-icons/ci";
import { MiniProfile } from "./mini-profile/mini-profile";
import { useSession } from "./session-context";
import { Tooltip } from "./ui/tooltip";

export const SignInbutton: React.FC = () => {
  const { session, user, setSession } = useSession();

  const sessionHandler = () => {
    setSession(true);
  };

  return (
    <Box>
      {session && user ? (
        <MiniProfile user={user} />
      ) : (
        <Box>
          <Box display={{ base: "none", xl: "inline" }}>
            <Button
              onClick={sessionHandler}
              bg="#1DA1F2"
              color="white"
              width="200px"
              size="lg"
              borderRadius="full"
            >
              Sign In
            </Button>
          </Box>
          <Tooltip content="SignIn" positioning={{ placement: "bottom" }}>
            <Box display={{ base: "inline", xl: "none" }}>
              <IconButton
                onClick={sessionHandler}
                bg="#1DA1F2"
                aria-label={"SignIn"}
                mx={3}
                borderRadius="full"
              >
                <CiLogin />
              </IconButton>
            </Box>
          </Tooltip>
        </Box>
      )}
    </Box>
  );
};
