import type { TimelineItem } from "@/lib/models/post";
import { Box, VStack } from "@chakra-ui/react";
import { memo } from "react";
import { NewPostsBanner } from "./new-posts-banner";
import { TimelineItemCard } from "./timeline-item-card";

interface TimelineFeedProps {
  timelineItems: TimelineItem[];
  errorMessage: string | null;
  newPostsCount: number;
  onLoadNewPosts: () => void;
}

const TimelineFeedComponent = ({
  timelineItems,
  errorMessage,
  newPostsCount,
  onLoadNewPosts,
}: TimelineFeedProps) => {
  if (errorMessage) {
    // Handling errors that cannot be caught by error.tsx from asynchronous processing.
    return <Box>{errorMessage}</Box>;
  }

  return (
    <Box>
      <NewPostsBanner count={newPostsCount} onLoadNewPosts={onLoadNewPosts} />
      {timelineItems.length === 0 ? (
        <Box>Post not found.</Box>
      ) : (
        <VStack align="stretch">
          {timelineItems.map((timelineItem) => (
            <TimelineItemCard
              key={timelineItem.id}
              timelineItem={timelineItem}
            />
          ))}
        </VStack>
      )}
    </Box>
  );
};

export const TimelineFeed = memo(TimelineFeedComponent);
