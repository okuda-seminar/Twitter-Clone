import { useRef, useState, useEffect } from "react";
import { FollowingPostsResponse } from "@/lib/actions/fetch-following-posts";
import { ERROR_MESSAGES } from "@/lib/constants/error-messages";

interface useTimelineFeedReturn {
  errorMessage: string | null;
  posts: FollowingPostsResponse;
}

export const useTimelineFeed = (): useTimelineFeedReturn => {
  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/516
  // - Add event type handling for SSE timeline streaming.
  const [posts, setPosts] = useState<FollowingPostsResponse>([]);
  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const eventSourceRef = useRef<EventSource | null>(null);
  const url: string = `${process.env.NEXT_PUBLIC_LOCAL_API_BASE_URL}/api/users/${process.env.NEXT_PUBLIC_USER_ID}/timelines/reverse_chronological`;

  useEffect(() => {
    if (eventSourceRef.current) return;

    const eventSource = new EventSource(url);

    eventSourceRef.current = eventSource;

    eventSource.onmessage = (event) => {
      try {
        const newPosts: FollowingPostsResponse = JSON.parse(event.data);
        if (newPosts.length === 0) {
          return;
        }
        setPosts((prevPosts) => [...newPosts, ...prevPosts]);
      } catch (err) {
        setErrorMessage(ERROR_MESSAGES.INVALID_DATA);
      }
    };

    eventSource.onerror = () => {
      setErrorMessage(ERROR_MESSAGES.SERVER_ERROR);
      eventSource.close();
      eventSourceRef.current = null;
    };

    return () => {
      eventSource.close();
      eventSourceRef.current = null;
    };
  }, [url]);

  return {
    errorMessage,
    posts,
  };
};
