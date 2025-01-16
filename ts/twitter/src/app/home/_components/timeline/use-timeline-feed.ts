import { useRef, useState, useEffect } from "react";
import { FollowingPostsResponse } from "@/lib/actions/fetch-following-posts";
import { ERROR_MESSAGES } from "@/lib/constants/error-messages";
import { Post } from "@/lib/models/post";

interface useTimelineFeedReturn {
  errorMessage: string | null;
  posts: FollowingPostsResponse;
}

export type TimelineEventResponse =
  | TimelineAccessedResponse
  | PostCreatedResponse
  | PostDeletedResponse;

export enum TimelineEventType {
  TimelineAccessed = "TimelineAccessed",
  PostCreated = "PostCreated",
  PostDeleted = "PostDeleted",
}

interface TimelineAccessedResponse {
  event_type: TimelineEventType.TimelineAccessed;
  posts: Post[];
}

interface PostCreatedResponse {
  event_type: TimelineEventType.PostCreated;
  posts: Post[];
}

interface PostDeletedResponse {
  event_type: TimelineEventType.PostDeleted;
  posts: Post[];
}

export const useTimelineFeed = (): useTimelineFeedReturn => {
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
        const newPosts: TimelineEventResponse = JSON.parse(event.data);
        switch (newPosts.event_type) {
          case TimelineEventType.TimelineAccessed:
          case TimelineEventType.PostCreated:
            if (!newPosts.posts || newPosts.posts.length === 0) {
              return;
            }
            setPosts((prevPosts) => [...newPosts.posts, ...prevPosts]);
            break;
          case TimelineEventType.PostDeleted:
            // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/540
            // - Implement timeline post deletion with SSE event handling.
            return;
        }
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
