"use client";
import React from 'react'
import {
  Button,
  Box,
  IconButton,
  Tooltip
} from '@chakra-ui/react'
import { FaFeather } from "react-icons/fa";

interface PostButtonProps {
    onOpen: () => void;
  }

const PostButton: React.FC<PostButtonProps> = ({ onOpen }) => (
    <>
      <Box display={{ base: "none", xl: "inline" }}>
        <Button bg="#1DA1F2" color="white" width="200px" size="lg" borderRadius="full" onClick={onOpen}>
          Post
        </Button>
      </Box>
      <Tooltip label={"Post"} placement="bottom">
        <Box display={{ base: "inline", xl: "none" }}>
          <IconButton bg="#1DA1F2" aria-label={"Post"} icon={<FaFeather/>} mx={4} borderRadius="full" onClick={onOpen}/>
        </Box>
      </Tooltip>
    </>
  )
  export default PostButton;
