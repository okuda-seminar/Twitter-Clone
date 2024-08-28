"use client";
import React from 'react'
import { useDisclosure } from '@chakra-ui/react';
import PostModal from './postmodal';
import PostButton from './postButton';

const Posts = () => {

  const { isOpen, onOpen, onClose } = useDisclosure();

  return (
    <>
      <PostButton onOpen={onOpen} />
      <PostModal isOpen={isOpen} onClose={onClose} />
    </>
  )
}

export default Posts
