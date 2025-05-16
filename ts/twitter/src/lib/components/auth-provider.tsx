import { verifySession } from "@/lib/actions/verify-session";
import { cookies } from "next/headers";
import { ClientAuthProvider } from "./auth-context";

interface AuthProviderProps {
  children: React.ReactNode;
}

export const AuthProvider: React.FC<AuthProviderProps> = async ({
  children,
}) => {
  const cookieStore = await cookies();
  const authToken = cookieStore.get("auth_token");

  let user = undefined;

  if (authToken) {
    try {
      const result = await verifySession();
      if (result.ok) {
        user = result.value;
      }
    } catch (error) {
      console.error("Session verification error:", error);
    }
  }

  return <ClientAuthProvider initialUser={user}>{children}</ClientAuthProvider>;
};
