import { SearchIcon } from "@/lib/components/icons";
import { Input, InputGroup } from "@chakra-ui/react";
import type React from "react";

export const SearchBar: React.FC = () => {
  return (
    <InputGroup startElement={<SearchIcon size="sm" />}>
      <Input placeholder="Search" />
    </InputGroup>
  );
};
