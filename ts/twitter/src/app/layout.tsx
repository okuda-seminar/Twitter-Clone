import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import { AuthProvider } from "@/lib/components/auth-context";
import { PageLayout } from "@/lib/components/page-layout";
import { Providers } from "@/lib/components/providers";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "Create Next App",
  description: "Generated by create next app",
};

export default function RootLayout({
  children,
  modal,
}: Readonly<{
  children: React.ReactNode;
  modal: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <Providers>
          <AuthProvider>
            <PageLayout modal={modal}>{children}</PageLayout>
          </AuthProvider>
        </Providers>
      </body>
    </html>
  );
}
