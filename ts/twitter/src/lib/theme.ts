import { createSystem, defaultConfig } from "@chakra-ui/react";

export const system = createSystem(defaultConfig, {
  theme: {
    tokens: {
      colors: {
        surface: {
          light: { value: "#FFFFFF" },
          dark: { value: "#000000" },
        },
        blue: {
          primary: { value: "#1DA1F2" },
          primaryHover: { value: "#1A91DA" },
        },
        error: {
          primary: { value: "#3D0105" },
        },
      },
    },
  },
});
