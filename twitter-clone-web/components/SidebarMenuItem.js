import { Flex, Text, Icon } from "@chakra-ui/react";

export default function SidebarMenuItem({ text, Icon, active }) {
  return (
    <Flex>
      <Icon as={Icon} boxSize={7} mr="2" />
      <Text>{text}</Text>
    </Flex>
  );
}
