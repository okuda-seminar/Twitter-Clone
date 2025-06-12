"use client";

import type { LoginBody } from "@/lib/actions/login";
import { useColorModeValue } from "@/lib/components/ui/color-mode";
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
    <Flex align="center" justify="center" minH="100vh">
      <Box
        width="600px"
        height="650px"
        bg={useColorModeValue("white", "black")}
        borderRadius="2xl"
        p={6}
        color={useColorModeValue("black", "white")}
        border="1px solid gray"
      >
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
