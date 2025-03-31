"use client";

import { Box, VStack } from "@chakra-ui/react";
import { TimelinePostCard } from "./timeline-post-card";
import type { useTimelineFeedReturn } from "./use-timeline-feed";

export const TimelineFeed = ({
  posts,
  errorMessage,
}: useTimelineFeedReturn) => {
  if (errorMessage) {
    // Handling errors that cannot be caught by error.tsx from asynchronous processing.
    return <Box>{errorMessage}</Box>;
  }
  if (posts.length === 0) {
    return <Box>Post not found.</Box>;
  }

  return (
    <VStack gap={4} align="stretch">
      {posts.map((post) => (
        <TimelinePostCard key={post.id} post={post} />
      ))}
    </VStack>
  );
};
