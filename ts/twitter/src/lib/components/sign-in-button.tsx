"use client";

import { Box, Button, IconButton, Tooltip } from "@chakra-ui/react";
import type React from "react";
import { CiLogin } from "react-icons/ci";
import { MiniProfile } from "./mini-profile/mini-profile";
import { useSession } from "./session-context";

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
          <Tooltip label={"SignIn"} placement="bottom">
            <Box display={{ base: "inline", xl: "none" }}>
              <IconButton
                onClick={sessionHandler}
                bg="#1DA1F2"
                aria-label={"SignIn"}
                icon={<CiLogin />}
                mx={4}
                borderRadius="full"
              />
            </Box>
          </Tooltip>
        </Box>
      )}
    </Box>
  );
};
