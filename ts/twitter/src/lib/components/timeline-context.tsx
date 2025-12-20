"use client";

import type { QuoteRepost } from "@/lib/models/post";
import type React from "react";
import {
  type PropsWithChildren,
  createContext,
  useCallback,
  useContext,
  useState,
} from "react";

interface OptimisticQuoteRepost extends QuoteRepost {
  isOptimistic?: boolean;
  tempId?: string;
}

interface TimelineContextType {
  addOptimisticQuoteRepost: (quoteRepost: OptimisticQuoteRepost) => void;
  removeOptimisticQuoteRepost: (tempId: string) => void;
  replaceOptimisticWithReal: (
    tempId: string,
    realQuoteRepost: QuoteRepost,
  ) => void;
  optimisticItems: OptimisticQuoteRepost[];
}

const TimelineContext = createContext<TimelineContextType | undefined>(
  undefined,
);

export const TimelineProvider: React.FC<PropsWithChildren> = ({ children }) => {
  const [optimisticItems, setOptimisticItems] = useState<
    OptimisticQuoteRepost[]
  >([]);

  const addOptimisticQuoteRepost = useCallback(
    (quoteRepost: OptimisticQuoteRepost) => {
      setOptimisticItems((prev) => [quoteRepost, ...prev]);
    },
    [],
  );

  const removeOptimisticQuoteRepost = useCallback((tempId: string) => {
    setOptimisticItems((prev) => prev.filter((item) => item.tempId !== tempId));
  }, []);

  const replaceOptimisticWithReal = useCallback(
    (tempId: string, realQuoteRepost: QuoteRepost) => {
      setOptimisticItems((prev) =>
        prev.map((item) =>
          item.tempId === tempId
            ? { ...realQuoteRepost, tempId, isOptimistic: false }
            : item,
        ),
      );
    },
    [],
  );

  return (
    <TimelineContext.Provider
      value={{
        addOptimisticQuoteRepost,
        removeOptimisticQuoteRepost,
        replaceOptimisticWithReal,
        optimisticItems,
      }}
    >
      {children}
    </TimelineContext.Provider>
  );
};

export const useTimeline = () => {
  const context = useContext(TimelineContext);
  if (!context) {
    throw new Error("useTimeline must be used within a TimelineProvider");
  }
  return context;
};

export type { OptimisticQuoteRepost };
