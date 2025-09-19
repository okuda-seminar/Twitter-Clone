import { Box, VStack } from "@chakra-ui/react";
import { TimelineItemCard } from "./timeline-item-card";
import type { useTimelineFeedReturn } from "./use-timeline-feed";

export const TimelineFeed = ({
  timelineItems,
  errorMessage,
}: useTimelineFeedReturn) => {
  if (errorMessage) {
    // Handling errors that cannot be caught by error.tsx from asynchronous processing.
    return <Box>{errorMessage}</Box>;
  }
  if (timelineItems.length === 0) {
    return <Box>Post not found.</Box>;
  }

  return (
    <VStack align="stretch">
      {timelineItems.map((timelineItem) => (
        <TimelineItemCard key={timelineItem.id} timelineItem={timelineItem} />
      ))}
    </VStack>
  );
};
