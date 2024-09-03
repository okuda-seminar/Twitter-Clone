"use client";
import { HStack } from "@chakra-ui/react";
import SideBar from "../shared/sidebar";

export default function Page() {
  return (
    <HStack align="start">
      <SideBar />
      <h1>community page</h1>
    </HStack>
  );
}
