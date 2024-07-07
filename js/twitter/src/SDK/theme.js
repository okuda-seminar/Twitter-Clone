import { extendTheme } from "@chakra-ui/react";
// import { mode } from "@chakra-ui/theme-tools";

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
  },
  styles: {
    global: (props) => ({
      // Example usage of branded colors.
      //   li: {
      //     bgColor: mode("surface.light", "surface.dark")(props),
      //   },
    }),
  },
};

export default extendTheme(theme);
