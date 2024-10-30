import { VStack } from "@chakra-ui/react";
import React from "react";
import { SearchBar } from "./search-bar";

export const RightColumn: React.FC = () => {
  return (
    <VStack>
      <SearchBar />
    </VStack>
  );
};
