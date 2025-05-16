import { verifySession } from "@/lib/actions/verify-session";
import { cookies } from "next/headers";
import { redirect } from "next/navigation";

export default async function ProtectedLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/733
  // - Add middleware to handle redirect decisions.
  const cookieStore = await cookies();
  const authToken = cookieStore.get("auth_token");

  if (!authToken) {
    redirect("/login");
  }

  try {
    const result = await verifySession();
    if (!result.ok) {
      redirect("/login");
    }
  } catch (error) {
    redirect("/login");
  }

  return children;
}
