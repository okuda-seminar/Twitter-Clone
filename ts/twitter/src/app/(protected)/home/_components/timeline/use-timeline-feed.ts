import { useAuth } from "@/lib/components/auth-context";
import type { TimelineItem } from "@/lib/models/post";
import { useRouter } from "next/navigation";
import { useCallback, useEffect, useRef, useState } from "react";
import {
  RestPollingTimelineFeedService,
  type TimelineFeedService,
  createTimelineFeedService,
} from "./timeline-feed-service";

export interface useTimelineFeedReturn {
  errorMessage: string | null;
  timelineItems: TimelineItem[];
  newPostsCount: number;
  loadNewPosts: () => void;
}

export const useTimelineFeed = (): useTimelineFeedReturn => {
  const router = useRouter();
  const [timelineItems, setTimelineItems] = useState<TimelineItem[]>([]);
  const [newPosts, setNewPosts] = useState<TimelineItem[]>([]);
  const { user } = useAuth();
  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const initialFetchServiceRef = useRef<TimelineFeedService | null>(null);
  const pollingServiceRef = useRef<RestPollingTimelineFeedService | null>(null);

  // Track latest state values to avoid race conditions in nested setState
  const latestTimelineItemsRef = useRef<TimelineItem[]>([]);
  const latestNewPostsRef = useRef<TimelineItem[]>([]);

  // Load new posts into timeline
  const loadNewPosts = useCallback(() => {
    setNewPosts((currentNewPosts) => {
      if (currentNewPosts.length === 0) return [];

      // Add new posts to timeline with duplicate check
      setTimelineItems((prevItems) => {
        const existingIds = new Set(prevItems.map((item) => item.id));
        const uniqueNewPosts = currentNewPosts.filter(
          (post) => !existingIds.has(post.id),
        );
        return [...uniqueNewPosts, ...prevItems];
      });

      // Clear new posts
      return [];
    });
  }, []);

  // Sync refs with state changes to avoid race conditions
  useEffect(() => {
    latestTimelineItemsRef.current = timelineItems;
  }, [timelineItems]);

  useEffect(() => {
    latestNewPostsRef.current = newPosts;
  }, [newPosts]);

  // Initial data fetch (SSR compatible)
  useEffect(() => {
    if (!user?.id) {
      router.push("/login");
      return;
    }

    const url: string = `${process.env.NEXT_PUBLIC_LOCAL_API_BASE_URL}/api/users/${user.id}/timelines/reverse_chronological`;

    if (!initialFetchServiceRef.current) {
      initialFetchServiceRef.current = createTimelineFeedService();
    }

    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/742
    // - Fix Timeline Post Display Issue After URL Changes.
    initialFetchServiceRef.current.connect(
      url,
      (initialItems) => {
        if (!initialItems || initialItems.length === 0) {
          return;
        }
        setTimelineItems(initialItems);
      },
      (error) => {
        setErrorMessage(error);
      },
    );

    return () => {
      initialFetchServiceRef.current?.disconnect();
    };
  }, [user, router]);

  // Polling for new data
  useEffect(() => {
    if (!user?.id || errorMessage) {
      return;
    }

    const url: string = `${process.env.NEXT_PUBLIC_LOCAL_API_BASE_URL}/api/users/${user.id}/timelines/reverse_chronological`;

    if (!pollingServiceRef.current) {
      pollingServiceRef.current = new RestPollingTimelineFeedService();
    }

    pollingServiceRef.current.startPolling(
      url,
      (polledItems) => {
        if (!polledItems || polledItems.length === 0) {
          return;
        }

        // Detect new posts (not in current timeline or new posts buffer)
        // Use refs to get the latest state values and avoid race conditions
        const currentTimelineItems = latestTimelineItemsRef.current;
        const currentNewPosts = latestNewPostsRef.current;

        // Get all existing IDs (timeline + new posts buffer)
        const existingIds = new Set([
          ...currentTimelineItems.map((item) => item.id),
          ...currentNewPosts.map((item) => item.id),
        ]);

        // Filter out items that already exist
        const freshPosts = polledItems.filter(
          (item) => !existingIds.has(item.id),
        );

        // Add fresh posts to the new posts buffer
        if (freshPosts.length > 0) {
          setNewPosts((prevNewPosts) => [...freshPosts, ...prevNewPosts]);
        }
      },
      (error, isFatal) => {
        if (isFatal) {
          // Only set error message on fatal errors (5 consecutive failures)
          setErrorMessage(error);
        }
      },
    );

    return () => {
      pollingServiceRef.current?.stopPolling();
    };
  }, [user?.id, errorMessage]);

  return {
    errorMessage,
    timelineItems,
    newPostsCount: newPosts.length,
    loadNewPosts,
  };
};
