import { login } from "@/lib/actions/login";
import { useAuth } from "@/lib/components/auth-context";
import { useRouter } from "next/navigation";

interface UsePasswordModalReturn {
  handleLoginAction: (
    prevState: string | undefined,
    formData: FormData,
  ) => Promise<string | undefined>;
}

export const usePasswordModal = (): UsePasswordModalReturn => {
  const router = useRouter();
  const { setUser } = useAuth();

  const handleLoginAction = async (
    prevState: string | undefined,
    formData: FormData,
  ) => {
    try {
      const username = formData.get("username") as string;
      const password = formData.get("password") as string;

      const result = await login({ username, password });

      if (!result.ok) {
        return `Login failed: ${result.error.statusText}`;
      }
      setUser(result.value.user);

      router.push("/home");
    } catch (error: unknown) {
      if (error instanceof Error) {
        return `Network error: ${error.message}`;
      }
      return "An unknown error occurred.";
    }
  };

  return {
    handleLoginAction,
  };
};
