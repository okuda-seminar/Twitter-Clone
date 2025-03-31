"use client";

import type { LoginBody } from "@/lib/actions/login";
import { Box, Flex } from "@chakra-ui/react";
import { useState } from "react";
import type React from "react";
import { AccountModal } from "./account-modal";
import { PasswordModal } from "./password-modal";

export const LoginModal: React.FC = () => {
  const [showPasswordModal, setShowPasswordModal] = useState(false);
  const [loginFormValue, setLoginFormValue] = useState<LoginBody>({
    username: "",
    password: "",
  });

  const handleNextButtonClick = () => {
    setShowPasswordModal(true);
  };

  const handleBackButtonClick = () => {
    setShowPasswordModal(false);
  };

  const handleUsernameChange = (username: string) => {
    setLoginFormValue({ ...loginFormValue, username });
  };

  const handlePasswordChange = (password: string) => {
    setLoginFormValue({ ...loginFormValue, password });
  };

  return (
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/621
    // - Add support for light mode in the login modal.
    <Flex align="center" justify="center" minH="100vh">
      <Box width="400px" bg="black" borderRadius="md" p={6} color="white">
        {!showPasswordModal ? (
          <AccountModal
            username={loginFormValue.username}
            handleNextButtonClick={handleNextButtonClick}
            handleUsernameChange={handleUsernameChange}
          />
        ) : (
          <PasswordModal
            loginFormValue={loginFormValue}
            handleBackButtonClick={handleBackButtonClick}
            handlePasswordChange={handlePasswordChange}
          />
        )}
      </Box>
    </Flex>
  );
};
