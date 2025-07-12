import { defineStyle } from "@chakra-ui/react";
import { useColorModeValue } from "../components/ui/color-mode";

export const floatingStyles = () =>
  defineStyle({
    pos: "absolute",
    bg: "transparent",
    px: "0.5",
    top: "1.5",
    insetStart: "2",
    fontWeight: "normal",
    pointerEvents: "none",
    transition: "position",
    color: useColorModeValue("gray.600", "gray.400"),
    fontSize: "xs",
    _peerPlaceholderShown: {
      color: "fg.muted",
      top: "5",
      insetStart: "3",
      fontSize: "md",
    },
    _peerFocusVisible: {
      color: useColorModeValue("blue.primary", "blue.300"),
      top: "1.5",
      insetStart: "2",
      fontSize: "xs",
    },
  });
