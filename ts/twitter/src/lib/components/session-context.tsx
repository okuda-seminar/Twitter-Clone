"use client";

import type { User } from "@/lib/models/user";
import type React from "react";
import { type ReactNode, createContext, useContext, useState } from "react";

interface SessionContextType {
  session: boolean;
  user: User | null;
  setSession: React.Dispatch<React.SetStateAction<boolean>>;
  setUser: React.Dispatch<React.SetStateAction<User | null>>;
}

const SessionContext = createContext<SessionContextType | undefined>(undefined);

export const SessionProvider: React.FC<{ children: ReactNode }> = ({
  children,
}) => {
  const [session, setSession] = useState(false);
  const [user, setUser] = useState<User | null>(null);

  const contextValue: SessionContextType = {
    session,
    user,
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/412 - Maintain Sign-In State on Page Refresh.
    setSession,
    setUser,
  };

  return (
    <SessionContext.Provider value={contextValue}>
      {children}
    </SessionContext.Provider>
  );
};

export const useSession = () => {
  const context = useContext(SessionContext);
  if (context === undefined) {
    throw new Error("useSession must be used within a SessionProvider");
  }
  return context;
};
