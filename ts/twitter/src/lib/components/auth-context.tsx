"use client";

import { verifySession } from "@/lib/actions/verify-session";
import type { User } from "@/lib/models/user";
import { useRouter } from "next/navigation";
import type React from "react";
import {
  type ReactNode,
  createContext,
  useContext,
  useEffect,
  useState,
} from "react";

interface AuthContextType {
  user: User | undefined;
  loading: boolean;
  setUser: React.Dispatch<React.SetStateAction<User | undefined>>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: ReactNode }> = ({
  children,
}) => {
  const [user, setUser] = useState<User | undefined>(undefined);
  const [loading, setLoading] = useState<boolean>(true);
  const router = useRouter();

  useEffect(() => {
    const checkSession = async () => {
      try {
        const result = await verifySession();
        if (result.ok) {
          setUser(result.value);
        } else {
          router.push("/login");
        }
      } catch (error) {
        router.push("/login");
      } finally {
        setLoading(false);
      }
    };
    checkSession();
  }, [router]);

  return (
    <AuthContext.Provider value={{ user, loading, setUser }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error("useAuth must be used within a AuthProvider");
  }
  return context;
};
