"use client";

import { Box, Button, IconButton, Spinner } from "@chakra-ui/react";
import { useRouter } from "next/navigation";
import type React from "react";
import { CiLogin } from "react-icons/ci";
import { useAuth } from "./auth-context";
import { MiniProfile } from "./mini-profile/mini-profile";
import { Tooltip } from "./ui/tooltip";

export const SignInbutton: React.FC = () => {
  const { user, loading } = useAuth();
  const router = useRouter();

  const dummyHandleSignIn = () => {
    router.push("/login");
  };

  if (loading) {
    return (
      <Box display="flex" justifyContent="center" alignItems="center" p={2}>
        <Spinner size="md" color="blue.primary" />
      </Box>
    );
  }

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
          <Tooltip content="SignIn" positioning={{ placement: "bottom" }}>
            <Box display={{ base: "inline", xl: "none" }}>
              <IconButton
                onClick={dummyHandleSignIn}
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
