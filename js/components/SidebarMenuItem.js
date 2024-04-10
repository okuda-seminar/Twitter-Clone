import { Flex, Text } from "@chakra-ui/react";
import React, { useState } from "react";

export default function SidebarMenuItem({ text, Icon, active }) {
  const [isHovered, setIsHovered] = useState(false);

  return (
    <Flex
      position="relative"
      color="gray.900"
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/88 - Define color constants and Remove all inline color definitions.
      borderRadius="full"
      alignItems="center"
      padding="3"
      _hover={{ bg: "gray.200" }}
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/88 - Define color constants and Remove all inline color definitions.

      fontSize="lg"
      direction={{ base: "column", xl: "row" }}
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
    >
      <Icon as={Icon} height="28px" />
      <Text
        fontWeight={active ? "bold" : "normal"}
        display={{ base: "none", xl: "inline" }}
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/88 - Define color constants and Remove all inline color definitions.
      >
        {text}
      </Text>

      <Text
        fontWeight={active ? "bold" : "normal"}
        fontSize="15px"
        backgroundColor="gray.400"
          display= {isHovered ? "inline" : "none" } 
          position= "absolute"
          top= "100%"           
          left= "50%" 
          transform= "translate(-50%, -50%)"         
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/88 - Define color constants and Remove all inline color definitions.
      >
        {text}
      </Text>
    </Flex>
  );
}
