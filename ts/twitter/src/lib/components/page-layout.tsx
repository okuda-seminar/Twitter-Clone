import { Box, Flex } from "@chakra-ui/react";
import type { ReactNode } from "react";
import { RightColumn } from "./right-column/right-column";
import { SideBar } from "./sidebar/sidebar";

interface PageLayoutProps {
  children: ReactNode;
  modal: ReactNode;
}

export const PageLayout = ({ children, modal }: PageLayoutProps) => {
  return (
    <Flex width="100%" height="100vh" divideY="2px">
      <Flex flex="1 1 20%" justifyContent="center">
        <SideBar />
      </Flex>
      <Box flex="1 1 40%">
        {modal}
        {children}
      </Box>
      <Box flex="1 1 30%">
        <RightColumn />
      </Box>
    </Flex>
  );
};
