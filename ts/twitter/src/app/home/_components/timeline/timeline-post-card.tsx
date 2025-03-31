import type { Post } from "@/lib/models/post";
import { Avatar, Box, Flex, Text } from "@chakra-ui/react";

interface TimelinePostCardProps {
  post: Post;
}

export const TimelinePostCard: React.FC<TimelinePostCardProps> = ({ post }) => {
  return (
    <Box key={post.id} p={4} borderWidth={1} borderRadius="md">
      <Flex>
        <Avatar.Root size="sm" mr={2}>
          <Avatar.Fallback name={post.user_id} />
        </Avatar.Root>
        <Text fontSize="sm" fontWeight="bold">
          {post.user_id}
        </Text>
      </Flex>
      <Text mt={2}>{post.text}</Text>
    </Box>
  );
};
