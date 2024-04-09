import { Flex, Text, Box } from "@chakra-ui/react";

export default function SidebarMenuItem({ text, Icon, active }) {
  return (
    <Flex
      color="gray.900"
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/88 - Define color constants and Remove all inline color definitions.
      borderRadius="full"
      alignItems="center"

      padding="3"
      _hover={{ bg: "gray.200" }}
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/88 - Define color constants and Remove all inline color definitions.

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
