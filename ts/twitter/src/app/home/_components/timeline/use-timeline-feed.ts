import { useSession } from "@/lib/components/session-context";
import type { Post } from "@/lib/models/post";
import { useEffect, useRef, useState } from "react";
import {
  type TimelineFeedService,
  createTimelineFeedService,
} from "./timeline-feed-service";

export interface useTimelineFeedReturn {
  errorMessage: string | null;
  posts: Post[];
}

export const useTimelineFeed = (): useTimelineFeedReturn => {
  const [posts, setPosts] = useState<Post[]>([]);
  const { user } = useSession();
  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const timelineFeedServiceRef = useRef<TimelineFeedService | null>(null);

  useEffect(() => {
    if (!user?.id) {
      setErrorMessage("User not logged in");
      return;
    }

    const url: string = `${process.env.NEXT_PUBLIC_LOCAL_API_BASE_URL}/api/users/${user.id}/timelines/reverse_chronological`;
    if (!timelineFeedServiceRef.current) {
      timelineFeedServiceRef.current = createTimelineFeedService();
    }

    timelineFeedServiceRef.current.connect(
      url,
      (newPosts) => {
        switch (newPosts.event_type) {
          case "TimelineAccessed":
          case "PostCreated":
            if (!newPosts.posts || newPosts.posts.length === 0) {
              return;
            }
            setPosts((prevPosts) => [...newPosts.posts, ...prevPosts]);
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
  }, [user]);

  return {
    errorMessage,
    posts,
  };
};
