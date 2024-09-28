import React, { useState, useEffect } from "react";
import axios from "axios";
import { Box, VStack, Text, Avatar, Flex } from "@chakra-ui/react";

interface Post {
  id: string;
  userId: string;
  userName: string;
  content: string;
}

const Feed: React.FC = () => {
  const [posts, setPosts] = useState<Post[]>([]);

  useEffect(() => {
    const fetchPosts = async () => {
      try {
        const response = await axios.get("http://localhost:3002/api/posts");
        setPosts(response.data);
      } catch (error) {
        console.error("Error fetching posts:", error);
      }
    };

    fetchPosts();
  }, [posts]);

  return (
    <VStack spacing={4} align="stretch">
      {posts.map((post) => (
        <Box key={post.id} p={4} borderWidth={1} borderRadius="md">
          <Flex>
            <Avatar size="sm" name={post.userName} mr={2} />
            <Text fontWeight="bold">{post.userName}</Text>
          </Flex>
          <Text mt={2}>{post.content}</Text>
        </Box>
      ))}
    </VStack>
  );
};

export default Feed;