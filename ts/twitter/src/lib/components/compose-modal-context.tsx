"use client";

import type { Post, QuoteRepost } from "@/lib/models/post";
import type React from "react";
import {
  type PropsWithChildren,
  createContext,
  useContext,
  useState,
} from "react";

interface ComposeModalContextType {
  quotedPost: Post | QuoteRepost | null;
  setQuotedPost: (post: Post | QuoteRepost | null) => void;
  clearModalState: () => void;
}

const ComposeModalContext = createContext<ComposeModalContextType | undefined>(
  undefined,
);

export const ComposeModalProvider: React.FC<PropsWithChildren> = ({
  children,
}) => {
  const [quotedPost, setQuotedPost] = useState<Post | QuoteRepost | null>(null);

  const clearModalState = () => {
    setQuotedPost(null);
  };

  return (
    <ComposeModalContext.Provider
      value={{ quotedPost, setQuotedPost, clearModalState }}
    >
      {children}
    </ComposeModalContext.Provider>
  );
};

export const useComposeModal = () => {
  const context = useContext(ComposeModalContext);
  if (!context) {
    throw new Error(
      "useComposeModal must be used within a ComposeModalProvider",
    );
  }
  return context;
};
