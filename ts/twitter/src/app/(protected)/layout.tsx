import { verifySession } from "@/lib/actions/verify-session";
import { AuthProvider } from "@/lib/components/auth-context";
import { PageLayout } from "@/lib/components/page-layout";
import { redirect } from "next/navigation";

export default async function ProtectedLayout({
  children,
  modal,
}: Readonly<{
  children: React.ReactNode;
  modal: React.ReactNode;
}>) {
  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/733
  // - Add middleware to handle redirect decisions.
  // But checking whether a user is authenticated in the layout is required.
  const result = await verifySession();
  if (!result.ok) {
    redirect("/login");
  }

  return (
    <AuthProvider user={result.value.user}>
      <PageLayout modal={modal}>{children}</PageLayout>
    </AuthProvider>
  );
}
