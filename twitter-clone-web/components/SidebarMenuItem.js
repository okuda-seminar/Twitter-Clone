import { Flex, Icon, Text } from "@chakra-ui/react";

export default function SidebarMenuItem({ text, Icon, active }) {
  return (
    <Flex
      className="hoverEffect"
      alignItems="center"
      color="gray.700"
      justifyContent="center"
      borderRadius="full"
      width="52px"
      height="52px"
      padding="3"
      _hover={{ bg: "gray.200" }}
      xl={{ justifyContent: "flex-start" }}
      fontSize="lg"
      spaceX="3"
    >
      <Icon as={Icon} boxSize={7} />
      <Text fontWeight={active ? "bold" : "normal"} display={{ base: "none", xl: "inline" }}>
        {text}
      </Text>
    </Flex>
  );
}
