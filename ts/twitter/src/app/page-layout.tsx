"use client";

import { Divider, Flex, Box } from "@chakra-ui/react";
import SideBar from "./shared/sidebar";
import { RightColumn } from "./home/right-column";
import { ReactNode } from "react";

interface LayoutProps {
  children: ReactNode;
}

export default function PageLayout({ children }: LayoutProps) {
  return (
    <Flex width="100%" height="100vh">
      <Flex flex="1 1 20%" justifyContent="center">
        <SideBar />
      </Flex>
      <Divider orientation="vertical" borderColor="white" />
      <Box flex="1 1 40%">{children}</Box>
      <Divider orientation="vertical" borderColor="white" />
      <Box flex="1 1 30%">
        <RightColumn />
      </Box>
    </Flex>
  );
}