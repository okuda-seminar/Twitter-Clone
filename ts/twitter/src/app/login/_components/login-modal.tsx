"use client";

import { Flex } from "@chakra-ui/react";
import { useState } from "react";
import type React from "react";
import { AccountModal } from "./account-modal";
import { PasswordModal } from "./password-modal";

export const LoginModal: React.FC = () => {
  const [showPasswordModal, setShowPasswordModal] = useState(false);

  return (
    <Flex align="center" justify="center" minH="100vh">
      {!showPasswordModal ? (
        <AccountModal onNext={() => setShowPasswordModal(true)} />
      ) : (
        <PasswordModal />
      )}
    </Flex>
  );
};
