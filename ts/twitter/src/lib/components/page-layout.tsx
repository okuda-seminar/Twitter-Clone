import { Divider, Flex, Box } from "@chakra-ui/react";
import { SideBar } from "./sidebar";
import { ReactNode } from "react";
import { RightColumn } from "./right-column";

interface PageLayoutProps {
  children: ReactNode;
  modal: ReactNode;
}

export const PageLayout = ({ children, modal }: PageLayoutProps) => {
  return (
    <Flex width="100%" height="100vh">
      <Flex flex="1 1 20%" justifyContent="center">
        <SideBar />
      </Flex>
      <Divider orientation="vertical" borderColor="white" />
      <Box flex="1 1 40%">
        {modal}
        {children}
      </Box>
      <Divider orientation="vertical" borderColor="white" />
      <Box flex="1 1 30%">
        <RightColumn />
      </Box>
    </Flex>
  );
};
