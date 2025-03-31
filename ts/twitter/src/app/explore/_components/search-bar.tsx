import { Input, InputGroup } from "@chakra-ui/react";
import type React from "react";
import { IoIosSearch } from "react-icons/io";

export const SearchBar: React.FC = () => {
  return (
    <InputGroup startElement={<IoIosSearch />}>
      <Input placeholder="Search" />
    </InputGroup>
  );
};
