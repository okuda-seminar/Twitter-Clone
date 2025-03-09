"use client";

import { Box, Flex } from "@chakra-ui/react";
import { useState } from "react";
import type React from "react";
import { AccountModal } from "./account-modal";
import { PasswordModal } from "./password-modal";

export const LoginModal: React.FC = () => {
  const [showPasswordModal, setShowPasswordModal] = useState(false);

  const handleNextButtonClick = () => {
    setShowPasswordModal(true);
  };

  return (
    <Flex align="center" justify="center" minH="100vh">
      <Box
        width="600px"
        height="650px"
        bg="black"
        borderRadius="md"
        display="flex"
        justifyContent="center"
        alignItems="center"
      >
        {!showPasswordModal ? (
          <AccountModal onNext={handleNextButtonClick} />
        ) : (
          <PasswordModal />
        )}
      </Box>
    </Flex>
  );
};
