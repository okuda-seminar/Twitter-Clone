import { useAuth } from "@/lib/components/auth-context";
import type { TimelineItem } from "@/lib/models/post";
import { useRouter } from "next/navigation";
import { useEffect, useRef, useState } from "react";
import {
  type TimelineFeedService,
  createTimelineFeedService,
} from "./timeline-feed-service";

export interface useTimelineFeedReturn {
  errorMessage: string | null;
  timelineItems: TimelineItem[];
}

export const useTimelineFeed = (): useTimelineFeedReturn => {
  const router = useRouter();
  const [timelineItems, setTimelineItems] = useState<TimelineItem[]>([]);
  const { user } = useAuth();
  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const timelineFeedServiceRef = useRef<TimelineFeedService | null>(null);

  useEffect(() => {
    if (!user?.id) {
      router.push("/login");
      return;
    }

    const url: string = `${process.env.NEXT_PUBLIC_LOCAL_API_BASE_URL}/api/users/${user.id}/timelines/reverse_chronological`;
    if (!timelineFeedServiceRef.current) {
      timelineFeedServiceRef.current = createTimelineFeedService();
    }

    timelineFeedServiceRef.current.connect(
      url,
      (newTimelineItems) => {
        switch (newTimelineItems.event_type) {
          case "TimelineAccessed":
          case "PostCreated":
            if (
              !newTimelineItems.timeline_items ||
              newTimelineItems.timeline_items.length === 0
            ) {
              return;
            }
            setTimelineItems((prevTimelineItems) => [
              ...newTimelineItems.timeline_items,
              ...prevTimelineItems,
            ]);
            break;
          case "PostDeleted":
            // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/540
            // - Implement timeline post deletion with SSE event handling.
            return;
        }
      },
      (error) => {
        setErrorMessage(error);
      },
    );

    return () => {
      timelineFeedServiceRef.current?.disconnect();
    };
  }, [user, router]);

  return {
    errorMessage,
    timelineItems,
  };
};
