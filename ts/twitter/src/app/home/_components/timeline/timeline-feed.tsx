"use client";

import { useRef, useState, useEffect } from "react";
import { VStack, Box } from "@chakra-ui/react";
import { TimelinePostCard } from "./timeline-post-card";
import { GetCollectionOfPostsBySpecificUserAndUsersTheyFollowResponse } from "@/lib/models/post";
import { ERROR_MESSAGES } from "@/lib/constants/error-messages";

export const TimelineFeed = () => {
  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/516 - Add event type handling for SSE timeline streaming.
  const [postText, setPostText] =
    useState<GetCollectionOfPostsBySpecificUserAndUsersTheyFollowResponse>([]);
  const [error, setError] = useState<Error | null>(null);
  const eventSourceRef = useRef<EventSource | null>(null);
  const url: string = `${process.env.NEXT_PUBLIC_LOCAL_API_BASE_URL}/api/users/${process.env.NEXT_PUBLIC_USER_ID}/timelines/reverse_chronological`;

  useEffect(() => {
    if (eventSourceRef.current) return;

    const eventSource = new EventSource(url);

    eventSourceRef.current = eventSource;

    eventSource.onmessage = (event) => {
      try {
        const parsedData = JSON.parse(event.data);
        if (!Array.isArray(parsedData) || parsedData.length === 0) {
          return;
        }
        setPostText((prevPosts) => [...parsedData, ...prevPosts]);
      } catch (err) {
        setError(Error(ERROR_MESSAGES.INVALID_DATA));
      }
    };

    eventSource.onerror = () => {
      setError(Error(ERROR_MESSAGES.SERVER_ERROR));
    };

    return () => {
      eventSource.close();
      eventSourceRef.current = null;
    };
  }, [url]);

  if (error) {
    // I implemented this because error.tsx cannot catch Thrown Errors from asynchronous processing.
    return <Box>{error.message}</Box>;
  } else if (postText.length === 0) {
    return <Box>Post not found.</Box>;
  } else {
    return (
      <VStack spacing={4} align="stretch">
        {postText.map((post) => (
          <TimelinePostCard key={post.id} post={post} />
        ))}
      </VStack>
    );
  }
};
