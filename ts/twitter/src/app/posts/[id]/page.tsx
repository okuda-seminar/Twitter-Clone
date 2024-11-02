"use client";

import React, { useState, useEffect } from "react";
import { useParams } from "next/navigation";
import axios from "axios";
import { Box, Flex, Avatar, Text, Button } from "@chakra-ui/react";
import { Post } from "@/lib/models/post";


enum FollowState {
  Follow,
  UnFollow,
}

enum PostFetchState {
  Loading,
  Error,
  Success,
}

export default function Page() {
  const [post, setPost] = useState<Post | null>(null);
  const [follow, setFollow] = useState<FollowState>(FollowState.UnFollow);
  const [followDisplayText, setFollowDisplayText] = useState<string>("follow");
  const [postState, setPostState] = useState<PostFetchState>(
    PostFetchState.Loading
  );
  const params = useParams();
  const id = params.id as string;

  useEffect(() => {
    switch (follow) {
      case FollowState.Follow:
        setFollowDisplayText("following");
        break;
      case FollowState.UnFollow:
        setFollowDisplayText("follow");
        break;
    }
  }, [follow]);

  useEffect(() => {
    const fetchPost = async () => {
      setPostState(PostFetchState.Loading);
      try {
        const response = await axios.get(
          `http://localhost:3002/api/posts/${id}`
        );
        setPost(response.data);
        setPostState(PostFetchState.Success);
      } catch (error) {
        setPostState(PostFetchState.Error);
        console.log("Post not found.");
      }
    };

    if (id) {
      fetchPost();
    }
  }, [id]);

  const toggleFollowState = () => {
    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/451 - Implement server request for follow button action.
    switch (follow) {
      case FollowState.UnFollow:
        setFollow(FollowState.Follow);
        break;
      case FollowState.Follow:
        setFollow(FollowState.UnFollow);
        break;
    }
  };

  switch (postState) {
    case PostFetchState.Loading:
      // The page reloads due to changes in the Poststate, which results in the termination of the session about sign in.
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/412 - Maintain Sign-In State on Page Refresh.
      return <Text>Loading...</Text>;
    case PostFetchState.Error:
      return <Text>Post not found</Text>;
    case PostFetchState.Success:
      return (
        <Box key={post?.id} p={8} borderWidth={1} borderRadius="md">
          <Flex>
            <Avatar size="md" name={post?.user_id} mr={2} />
            <Text fontWeight="bold" fontSize="xl" mr={4}>
              {post?.user_id}
            </Text>
            <Button borderRadius="full" onClick={toggleFollowState}>
              {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/452 - Hide follow button for user's own posts in post detail page. */}
              {followDisplayText}
            </Button>
          </Flex>
          <Text mt={10} fontSize="xl">
            {post?.text}
          </Text>
        </Box>
      );
  }
}
