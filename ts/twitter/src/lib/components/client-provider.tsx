"use client";

import dynamic from "next/dynamic";

const DynamicProvider = dynamic(
  () => import("@/lib/components/ui/provider").then((mod) => mod.Provider),
  {
    ssr: false,
  },
);

export default function ClientProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  return <DynamicProvider>{children}</DynamicProvider>;
}
