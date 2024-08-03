"use client";
import { HStack } from "@chakra-ui/react";
import SideBar from "../shared/sidebar";

export default function Page() {
  return (
    <HStack align="start">
      <SideBar />
      <h1>profile page</h1>
    </HStack>
  )
}