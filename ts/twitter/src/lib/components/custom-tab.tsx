"use client";

import { Tab, useColorModeValue } from "@chakra-ui/react";
import type React from "react";

interface CustomTabProps {
  tabWidth: string;
  message: string;
  fontSize: string;
}

export const CustomTab: React.FC<CustomTabProps> = ({
  tabWidth,
  message,
  fontSize,
}) => {
  return (
    <Tab
      width={tabWidth}
      _hover={{
        background: useColorModeValue("gray.100", "transparent"),
      }}
      fontSize={fontSize}
    >
      {message}
    </Tab>
  );
};
