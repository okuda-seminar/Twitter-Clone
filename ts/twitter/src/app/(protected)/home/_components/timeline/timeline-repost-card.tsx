import { RepostIcon } from "@/lib/components/icons";
import type { Post, Repost } from "@/lib/models/post";
import { Box, Flex, IconButton, Text } from "@chakra-ui/react";
import { TimelineItemFrame } from "./timeline-item-frame";

interface TimelineRepostCardProps {
  repost: Repost;
}

export const TimelineRepostCard: React.FC<TimelineRepostCardProps> = () => {
  // Dummy data
  const post: Post = {
    type: "post",
    id: "123",
    author_id: "test",
    text: "test post",
    created_at: "2024-01-01T00:00:00Z",
  };

  return (
    <Box p="4" borderBottomWidth="1px">
      <Flex gap="2" mb="2">
        <IconButton
          minW={0}
          ml="6"
          height="4"
          bg="transparent"
          borderRadius="full"
          aria-label="Repost"
          color="gray.500"
          _hover={{ color: "green.400" }}
          size="sm"
          variant="ghost"
        >
          <RepostIcon boxSize="4" />
        </IconButton>
        <Text
          fontWeight="bold"
          fontSize="sm"
          color="gray.500"
          lineHeight="16px"
        >
          name reposted
        </Text>
      </Flex>
      <TimelineItemFrame timelineItem={post}>
        <Text whiteSpace="pre-wrap">{post.text}</Text>
      </TimelineItemFrame>
    </Box>
  );
};
