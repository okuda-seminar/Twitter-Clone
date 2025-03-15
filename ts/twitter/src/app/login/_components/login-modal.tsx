"use client";

import { Box, Flex } from "@chakra-ui/react";
import { useState } from "react";
import type React from "react";
import { AccountModal } from "./account-modal";
import { PasswordModal } from "./password-modal";

export const LoginModal: React.FC = () => {
  const [showPasswordModal, setShowPasswordModal] = useState(false);
  const [username, setUsername] = useState("");

  const handleNextButtonClick = (enteredUsername: string) => {
    setUsername(enteredUsername);
    setShowPasswordModal(true);
  };

  return (
    <Flex align="center" justify="center" minH="100vh">
      <Box
        width="400px"
        bg="black"
        borderRadius="md"
        p={6}
        color="white"
        display="flex"
        flexDirection="column"
        gap={6}
      >
        {!showPasswordModal ? (
          <AccountModal onNext={handleNextButtonClick} />
        ) : (
          <PasswordModal username={username} />
        )}
      </Box>
    </Flex>
  );
};
