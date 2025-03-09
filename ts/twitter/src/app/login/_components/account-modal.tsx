"use client";

import { Button } from "@chakra-ui/react";
import type React from "react";

interface AccountModalProps {
  onNext: () => void;
}

export const AccountModal: React.FC<AccountModalProps> = ({ onNext }) => {
  return (
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
  );
};
