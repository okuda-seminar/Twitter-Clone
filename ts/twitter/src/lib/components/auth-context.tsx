"use client";

import { verifySession } from "@/lib/actions/verify-session";
import type { User } from "@/lib/models/user";
import type React from "react";
import {
  type ReactNode,
  createContext,
  useContext,
  useEffect,
  useState,
} from "react";
import { ERROR_MESSAGES } from "../constants/error-messages";

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

  useEffect(() => {
    const checkSession = async () => {
      try {
        const result = await verifySession();
        if (result.ok) {
          setUser(result.value);
        }
      } catch (error) {
        throw new Error(ERROR_MESSAGES.AUTH_CHECK_ERROR);
      } finally {
        setLoading(false);
      }
    };

    checkSession();

    return;
  }, []);

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
