"use client";

import React from "react";
import { IconButton, Tooltip, Box, Button } from "@chakra-ui/react";
import { CiLogin } from "react-icons/ci";
import { useSession } from "./session-context";
import MiniProfile from "@/app/user/mini-profile";

export default function SignInbutton() {
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
}
