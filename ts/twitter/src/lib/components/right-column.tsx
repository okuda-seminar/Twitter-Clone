import { VStack } from "@chakra-ui/react";
import type React from "react";
import { SearchBar } from "./search-bar";

export const RightColumn: React.FC = () => {
  return (
    <VStack>
      <SearchBar />
    </VStack>
  );
};
