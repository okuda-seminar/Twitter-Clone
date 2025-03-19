"use client";

import { system } from "@/lib/theme";
import { ChakraProvider } from "@chakra-ui/react";
import type * as React from "react";
import { ColorModeProvider, type ColorModeProviderProps } from "./color-mode";

interface ProviderProps extends ColorModeProviderProps {
  children: React.ReactNode;
}

export function Provider({ children, ...colorModeProps }: ProviderProps) {
  return (
    <ChakraProvider value={system}>
      <ColorModeProvider {...colorModeProps}>{children}</ColorModeProvider>
    </ChakraProvider>
  );
}
