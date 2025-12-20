import { verifySession } from "@/lib/actions/verify-session";
import { AuthProvider } from "@/lib/components/auth-context";
import { ComposeModalProvider } from "@/lib/components/compose-modal-context";
import { PageLayout } from "@/lib/components/page-layout";
import { TimelineProvider } from "@/lib/components/timeline-context";
import { redirect } from "next/navigation";

export default async function ProtectedLayout({
  children,
  modal,
}: Readonly<{
  children: React.ReactNode;
  modal: React.ReactNode;
}>) {
  const result = await verifySession();
  if (!result.ok) {
    redirect("/login");
  }

  return (
    <AuthProvider user={result.value.user}>
      <ComposeModalProvider>
        <TimelineProvider>
          <PageLayout modal={modal}>{children}</PageLayout>
        </TimelineProvider>
      </ComposeModalProvider>
    </AuthProvider>
  );
}
