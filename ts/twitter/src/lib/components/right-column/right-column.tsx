import { VStack } from "@chakra-ui/react";
import { Input, InputGroup, InputLeftElement } from "@chakra-ui/react";
import type React from "react";
import { IoIosSearch } from "react-icons/io";

export const RightColumn: React.FC = () => {
  return (
    <VStack>
      <InputGroup>
        <InputLeftElement pointerEvents="none">
          <IoIosSearch color="gray.300" />
        </InputLeftElement>
        <Input placeholder="Search" />
      </InputGroup>
    </VStack>
  );
};
