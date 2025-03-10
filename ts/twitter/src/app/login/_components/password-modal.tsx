"use client";

import { Box, Button } from "@chakra-ui/react";
import { useRouter } from "next/navigation";
import type React from "react";

export const PasswordModal: React.FC = () => {
  const router = useRouter();

  return (
    <Box
      width="600px"
      height="650px"
      bg="black"
      borderRadius="md"
      display="flex"
      justifyContent="center"
      alignItems="center"
    >
      <Button
        onClick={() => router.push("/home")}
        fontSize="lg"
        borderRadius="full"
        bg="white"
        color="black"
        fontWeight="bold"
      >
        Login
      </Button>
    </Box>
  );
};
