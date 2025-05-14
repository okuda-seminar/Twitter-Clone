"use client";

import type { User } from "@/lib/models/user";
import type React from "react";
import { type PropsWithChildren, createContext, useContext } from "react";

interface AuthContextType {
  user: User | undefined;
}

const AuthContext = createContext<AuthContextType>({ user: undefined });

export const AuthProvider: React.FC<PropsWithChildren<AuthContextType>> = ({
  children,
  user,
}) => {
  return (
    <AuthContext.Provider value={{ user }}>{children}</AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error("useAuth must be used within an AuthProvider");
  }
  return context;
};
