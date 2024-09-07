import React from "react";
import { Input, InputGroup, InputLeftElement, VStack } from "@chakra-ui/react";
import { IoIosSearch } from "react-icons/io";

export const RightColumn: React.FC = () => {
  return (
    <VStack>
      <SearchBar />
    </VStack>
  );
};

const SearchBar: React.FC = () => {
  return (
    <InputGroup>
      <InputLeftElement pointerEvents="none">
        <IoIosSearch color="gray.300" />
      </InputLeftElement>
      <Input placeholder="Search" />
    </InputGroup>
  );
};
