import type { Post } from "@/lib/models/post";
import { Box, Text } from "@chakra-ui/react";
import { TimelineItemFrame } from "./timeline-item-frame";

interface TimelinePostCardProps {
  post: Post;
}

export const TimelinePostCard: React.FC<TimelinePostCardProps> = ({ post }) => {
  return (
    <Box p="4" borderBottomWidth="1px">
      <TimelineItemFrame timelineItem={post}>
        <Text whiteSpace="pre-wrap">{post.text}</Text>
      </TimelineItemFrame>
    </Box>
  );
};
