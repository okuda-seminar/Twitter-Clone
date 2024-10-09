"use client";
import React, { useState } from "react";
import {
  Button,
  Modal,
  ModalOverlay,
  ModalContent,
  ModalBody,
  ModalCloseButton,
  Textarea,
  Flex,
  Box,
  IconButton,
  Avatar,
} from "@chakra-ui/react";
import { FaImage } from "react-icons/fa6";
import axios from "axios";

interface PostModalProps {
  isOpen: boolean;
  onClose: () => void;
  name: string;
  id: string;
}

const PostModal: React.FC<PostModalProps> = ({ isOpen, onClose, name, id }) => {
  const [postState, setPostState] = useState<string>("");

  const textChangeHandler = (event: React.ChangeEvent<HTMLTextAreaElement>) => {
    setPostState(event.target.value);
  };

  const postSubmitHandler = async () => {
    try {
      const response = await axios.post("http://localhost:3002/api/posts", {
        userId: id,
        userName: name,
        text: postState,
      });

      if (response.status === 201) {
        console.log("Post created successfully");
        setPostState("");
        onClose();
      }
    } catch (error) {
      console.error("Error creating post:", error);
    }
  };

  const closeButttonHandler = () => {
    setPostState("");
  };

  return (
    <Modal isOpen={isOpen} onClose={onClose} size="xl">
      <ModalOverlay />
      <ModalContent bg="black" color="white">
        <ModalCloseButton
          onClick={closeButttonHandler}
          color="white"
          position="absolute"
          top="8px"
          left="8px"
        />
        <ModalBody py={4}>
          <Flex mt={8}>
            <Avatar size="md" name={name} />
            <Textarea
              value={postState}
              onChange={textChangeHandler}
              placeholder="What is happening?!"
              border="none"
              resize="none"
              minH="100px"
              _focus={{ boxShadow: "none" }}
              fontSize="xl"
            />
          </Flex>
          <Box borderTop="1px solid" borderColor="gray.600" mt={4} pt={4}>
            <Flex justifyContent="space-between">
              <IconButton
                // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/407 - Enhance Post Functionality: Add Image Attachment Feature.

                icon={<FaImage />}
                aria-label="Add image"
                variant="ghost"
                color="blue.400"
                borderRadius="full"
                _hover={{ bg: "whiteAlpha.200" }}
              />
              <Button
                onClick={postSubmitHandler}
                isDisabled={postState.trim() === ""}
                bg="#1DA1F2"
                color="white"
                borderRadius="full"
                px={4}
                _hover={{ bg: "#1a91da" }}
              >
                Post
              </Button>
            </Flex>
          </Box>
        </ModalBody>
      </ModalContent>
    </Modal>
  );
};
export default PostModal;
