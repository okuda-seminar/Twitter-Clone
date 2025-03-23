"use client";

import { Box, Button, IconButton, Tooltip } from "@chakra-ui/react";
import { useRouter } from "next/navigation";
import type React from "react";
import { CiLogin } from "react-icons/ci";
import { useAuth } from "./auth-context";
import { MiniProfile } from "./mini-profile/mini-profile";

export const SignInbutton: React.FC = () => {
  const { user } = useAuth();
  const router = useRouter();

  // This is a temporary sign-in handler.
  // When clicked, it redirects the user to the login page.
  // In the future, this will be replaced with a real authentication flow.
  const dummyHandleSignIn = () => {
    router.push("/login");
  };

  return (
    <Box>
      {user ? (
        <MiniProfile user={user} />
      ) : (
        <Box>
          <Box display={{ base: "none", xl: "inline" }}>
            <Button
              onClick={dummyHandleSignIn}
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
                onClick={dummyHandleSignIn}
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
