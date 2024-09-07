"use client";
import { HStack } from "@chakra-ui/react";
import SideBar from "../shared/sidebar";
import Home from "./home";
import { RightColumn } from "./right-column";

export default function Page() {
  return (
    <HStack align="start">
      <SideBar />
      <Home />
      <RightColumn />
    </HStack>
  );
}
