"use client";

import { Button } from "@chakra-ui/react";
import { useRouter } from "next/navigation";
import type React from "react";

export const PasswordModal: React.FC = () => {
  const router = useRouter();

  return (
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
  );
};
