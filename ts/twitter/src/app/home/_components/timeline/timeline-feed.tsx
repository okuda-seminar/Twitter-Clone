"use client";

import { Box, VStack } from "@chakra-ui/react";
import { TimelinePostCard } from "./timeline-post-card";
import { useTimelineFeed } from "./use-timeline-feed";

export const TimelineFeed = () => {
  const { posts, errorMessage } = useTimelineFeed();

  if (errorMessage) {
    // Handling errors that cannot be caught by error.tsx from asynchronous processing.
    return <Box>{errorMessage}</Box>;
  }
  if (posts.length === 0) {
    return <Box>Post not found.</Box>;
  }

  return (
    <VStack spacing={4} align="stretch">
      {posts.map((post) => (
        <TimelinePostCard key={post.id} post={post} />
      ))}
    </VStack>
  );
};
