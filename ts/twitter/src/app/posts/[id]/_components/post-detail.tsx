"use client";

import type { Post } from "@/lib/models/post";
import { Avatar, Box, Button, Flex, Text } from "@chakra-ui/react";
import { useState } from "react";
import { mockPost } from "../mocks/post";

export const PostDetail = () => {
  const post: Post = mockPost;
  const [isFollowing, setIsFollowing] = useState<boolean>(false);
  const toggleFollowState = () => setIsFollowing((prev) => !prev);

  return (
    <Box key={post.id} p={8} borderWidth={1} borderRadius="md">
      <Flex>
        <Avatar size="md" name={post.user_id} mr={2} />
        <Text fontWeight="bold" fontSize="xl" mr={4} mt={2}>
          {post.user_id}
        </Text>
        <Button borderRadius="full" onClick={toggleFollowState}>
          {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/452 
            - Hide follow button for user's own posts in post detail page. */}
          {isFollowing ? "Following" : "Follow"}
        </Button>
      </Flex>
      <Text mt={10} fontSize="xl">
        {post.text}
      </Text>
    </Box>
  );
};
