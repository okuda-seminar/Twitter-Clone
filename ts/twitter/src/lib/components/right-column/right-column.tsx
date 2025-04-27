import { Input, InputGroup } from "@chakra-ui/react";
import type React from "react";
import { SearchIcon } from "../icons";

export const RightColumn: React.FC = () => {
  return (
    <InputGroup startElement={<SearchIcon size="sm" />}>
      <Input placeholder="Search" />
    </InputGroup>
  );
};
