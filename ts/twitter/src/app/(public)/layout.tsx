import { verifySession } from "@/lib/actions/verify-session";
import { redirect } from "next/navigation";

export default async function PublicLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const result = await verifySession();
  if (result.ok) {
    redirect("/");
  }

  return children;
}
