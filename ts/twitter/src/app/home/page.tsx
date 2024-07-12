"use client";
import { HStack } from "@chakra-ui/react";
import SideBar from "../shared/sidebar";
import Home from "./home";

export default function Page() {
  return (
    <HStack align="start">
      <SideBar />
      <Home />
    </HStack>
  );
}
