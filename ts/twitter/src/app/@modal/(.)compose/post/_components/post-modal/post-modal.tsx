"use client";

import React, { useRef } from "react";
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
import { usePostModal } from "./use-post-modal";
import { useSession } from "@/lib/components/session-context";

interface PostModalProps {
  isIntercepted: boolean;
}

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/500
// Disable scrolling to the top of the page when the post modal opens.
export const PostModal: React.FC<PostModalProps> = ({ isIntercepted }) => {
  const { user } = useSession();
  const {
    handleCloseButtonClick,
    postText,
    handleTextAreaChange,
    handlePostButtonClick,
    isPostButtonDisabled,
  } = usePostModal({ isIntercepted });
  const initialRef = useRef(null);

  return (
    <Modal
      initialFocusRef={initialRef}
      isOpen={true}
      onClose={handleCloseButtonClick}
      size="xl"
    >
      <ModalOverlay />
      <ModalContent bg="black" color="white">
        <ModalCloseButton
          color="white"
          position="absolute"
          top="8px"
          left="8px"
        />
        <ModalBody py={4}>
          <Flex mt={8}>
            <Avatar size="md" name={user ? user?.name : ""} />
            <Textarea
              ref={initialRef}
              value={postText}
              onChange={handleTextAreaChange}
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
                onClick={handlePostButtonClick}
                isDisabled={isPostButtonDisabled}
                bg="blue.primary"
                color="white"
                borderRadius="full"
                px={4}
                _hover={{ bg: "blue.primaryHover" }}
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
