import { Flex, Text, Box } from "@chakra-ui/react";

export default function SidebarMenuItem({ text, Icon, active }) {
  return (
    <Flex
      color="gray.900"
      borderRadius="full"
      alignItems="center"

      padding="3"
      _hover={{ bg: "gray.200" }}

      fontSize="lg"
      direction={{ base: "column", xl: "row" }}
    >
      <Icon as={Icon} height="28px" />
      <Text fontWeight={active ? "bold" : "normal"} display={{ base: "none",xl: "inline" }}>
        {text}
      </Text>
    </Flex>
  );
}
