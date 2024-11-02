import React from "react";
import { Input, InputGroup, InputLeftElement } from "@chakra-ui/react";
import { IoIosSearch } from "react-icons/io";

export const SearchBar: React.FC = () => {
  return (
    <InputGroup>
      <InputLeftElement pointerEvents="none">
        <IoIosSearch color="gray.300" />
      </InputLeftElement>
      <Input placeholder="Search" />
    </InputGroup>
  );
};
