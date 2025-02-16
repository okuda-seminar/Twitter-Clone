import type { Post } from "@/lib/models/post";
import { Avatar, Box, Flex, Text } from "@chakra-ui/react";

interface TimelinePostCardProps {
  post: Post;
}

export const TimelinePostCard: React.FC<TimelinePostCardProps> = ({ post }) => {
  return (
    <Box key={post.id} p={4} borderWidth={1} borderRadius="md">
      <Flex>
        <Avatar size="sm" name={post.user_id} mr={2} />
        <Text size="sm" fontWeight="bold">
          {post.user_id}
        </Text>
      </Flex>
      <Text mt={2}>{post.text}</Text>
    </Box>
  );
};
