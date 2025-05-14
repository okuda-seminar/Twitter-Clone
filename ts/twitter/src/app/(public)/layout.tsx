import { verifySession } from "@/lib/actions/verify-session";
import { redirect } from "next/navigation";

export default async function PublicLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/733
  // - Add middleware to handle redirect decisions.
  // But checking whether a user is authenticated in the layout is required.
  const result = await verifySession();
  if (result.ok) {
    redirect("/");
  }

  return children;
}
