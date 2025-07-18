import type { Metadata } from "next";
import { Inter } from "next/font/google";
import ClientProvider from "../lib/components/client-provider";

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
  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/672
  // - Fix UI layout issues on mobile view.
  return (
    <html lang="en">
      <body className={inter.className} suppressHydrationWarning>
        <ClientProvider>{children}</ClientProvider>
      </body>
    </html>
  );
}
