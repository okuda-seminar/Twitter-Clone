"use client";
import { HStack } from "@chakra-ui/react";
import SideBar from "../shared/sidebar";
import MainContent from "./main_content";

export default function Page() {
  return (
    <HStack align="start">
      <SideBar />
      <MainContent />
    </HStack>
  );
}
