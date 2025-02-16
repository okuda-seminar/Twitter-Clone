import { VStack } from "@chakra-ui/react";
import type React from "react";
import { SearchBar } from "./search-bar";
import { SearchTabBar } from "./search-tab-bar";

export const Explore: React.FC = () => {
  return (
    <VStack>
      <SearchBar />
      <SearchTabBar />
    </VStack>
  );
};
