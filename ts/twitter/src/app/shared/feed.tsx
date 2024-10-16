"use client"
import React, { useState, useEffect } from "react";
import axios from "axios";
import { Box, VStack, Text, Avatar, Flex, Link } from "@chakra-ui/react";

interface Post {
  id: string;
  user_id: string;
  text: string;
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
        <Link href={`/posts/${post.id}`} key={post.id}>
          <Box key={post.id} p={4} borderWidth={1} borderRadius="md">
            <Flex>
              <Avatar size="sm" name={post.user_id} mr={2} />
              <Text fontWeight="bold">{post.user_id}</Text>
            </Flex>
            <Text mt={2}>{post.text}</Text>
          </Box>
        </Link>
      ))}
    </VStack>
  );
};

export default Feed;
