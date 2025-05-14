"use client";

import type { User } from "@/lib/models/user";
import type React from "react";
import { type ReactNode, createContext, useContext, useState } from "react";

interface AuthContextType {
  user: User | undefined;
  setUser: React.Dispatch<React.SetStateAction<User | undefined>>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

interface ClientAuthProviderProps {
  children: ReactNode;
  initialUser?: User;
}

export const ClientAuthProvider: React.FC<ClientAuthProviderProps> = ({
  children,
  initialUser,
}) => {
  const [user, setUser] = useState<User | undefined>(initialUser);

  return (
    <AuthContext.Provider value={{ user, setUser }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error("useAuth must be used within a ClientAuthProvider");
  }
  return context;
};
