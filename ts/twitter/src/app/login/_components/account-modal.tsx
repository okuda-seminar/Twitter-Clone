"use client";

import { Box, Button } from "@chakra-ui/react";
import type React from "react";

interface AccountModalProps {
  onNext: () => void;
}

export const AccountModal: React.FC<AccountModalProps> = ({ onNext }) => {
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
        onClick={onNext}
        fontSize="lg"
        borderRadius="full"
        bg="white"
        color="black"
        fontWeight="bold"
      >
        Next
      </Button>
    </Box>
  );
};
