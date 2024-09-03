import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import { Providers } from "./providers";
import { ColorModeScript } from "@chakra-ui/react";
import theme from "./shared/theme";
import { SessionProvider } from "./auth/sessioncontext";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "Create Next App",
  description: "Generated by create next app",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <ColorModeScript initialColorMode={theme.config.initialColorMode} />
          <Providers>
            <SessionProvider>{children}</SessionProvider>
          </Providers>
      </body>
    </html>
  );
}
