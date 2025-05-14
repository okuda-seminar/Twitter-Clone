import type { TimelineItem } from "@/lib/models/post";
import { Avatar, Box, Flex, Text } from "@chakra-ui/react";

interface TimelinePostCardProps {
  timelineItem: TimelineItem;
}

export const TimelinePostCard: React.FC<TimelinePostCardProps> = ({
  timelineItem,
}) => {
  return (
    <Box key={timelineItem.id} p={4} borderWidth={1} borderRadius="md">
      <Flex>
        <Avatar.Root size="sm" mr={2}>
          <Avatar.Fallback name={timelineItem.author_id} />
        </Avatar.Root>
        <Text fontSize="sm" fontWeight="bold">
          {timelineItem.author_id}
        </Text>
      </Flex>
      {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/640
      - Implement dedicated components for each type of timeline item. */}
      {timelineItem.type === "post" && <Text mt={2}>{timelineItem.text}</Text>}
    </Box>
  );
};
