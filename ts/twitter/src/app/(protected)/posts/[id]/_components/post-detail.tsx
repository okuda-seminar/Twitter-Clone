"use client";

import { useColorModeValue } from "@/lib/components/ui/color-mode";
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
        <Avatar.Root size="md">
          <Avatar.Fallback name={post.authorId} mr={2} />
          <Avatar.Image />
        </Avatar.Root>
        <Flex flex="1" alignItems="center" ml={2}>
          <Text fontWeight="bold" fontSize="xl">
            {post.authorId}
          </Text>
          <Button
            borderRadius="full"
            ml={2}
            onClick={toggleFollowState}
            fontSize="md"
            bg="gray.100"
            color={useColorModeValue("black", "white")}
          >
            {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/452 
            - Hide follow button for user's own posts in post detail page. */}
            {isFollowing ? "Following" : "Follow"}
          </Button>
        </Flex>
      </Flex>
      <Text mt={10} fontSize="xl">
        {post.text}
      </Text>
    </Box>
  );
};
