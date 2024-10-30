import { extendTheme } from "@chakra-ui/react";

const theme = {
  config: {
    initialColorMode: "system",
    useSystemColorMode: true,
  },
  colors: {
    surface: {
      light: "#FFFFFF",
      dark: "#000000",
    },
    blue: {
      primary: "#1DA1F2",
      primaryHover: "#1A91DA",
    },
  },
};

export default extendTheme(theme);
