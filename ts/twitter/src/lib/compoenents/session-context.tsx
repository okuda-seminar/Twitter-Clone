"use client";
import React, { createContext, useState, useContext, ReactNode } from "react";

export interface User {
  name: string;
  id: string;
}

interface SessionContextType {
  session: boolean;
  user: User | null;
  setSession: React.Dispatch<React.SetStateAction<boolean>>;
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
    setSession: (newSession) => {
      setSession(newSession);
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/412 - Maintain Sign-In State on Page Refresh.

      if (newSession) {
        setUser({ name: "Example User", id: "@123456789" });
        // Hardcoded username, user ID, and user icon.
      } else {
        setUser(null);
      }
    },
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
