"use client";

import { useSession } from "@/lib/components/session-context";
import {
  Avatar,
  Box,
  Flex,
  IconButton,
  Modal,
  ModalBody,
  ModalCloseButton,
  ModalContent,
  ModalOverlay,
  Text,
  Textarea,
} from "@chakra-ui/react";
import type React from "react";
import { useRef } from "react";
import { useFormState } from "react-dom";
import { FaImage } from "react-icons/fa6";
import { PostButton } from "../post-button/post-button";
import { usePostModal } from "./use-post-modal";

interface PostModalProps {
  isIntercepted: boolean;
}

export const PostModal: React.FC<PostModalProps> = ({ isIntercepted }) => {
  const { user } = useSession();
  const {
    handleCloseButtonClick,
    postText,
    handleTextAreaChange,
    handlePostButtonClick,
    isPostButtonDisabled,
  } = usePostModal({ isIntercepted });

  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/525
  // - Replace useFormState with useActionState after upgrading React to v19.
  const [message, formAction] = useFormState(handlePostButtonClick, undefined);
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
        <ModalBody pt="53px" pb={4}>
          <form action={formAction}>
            {message !== undefined && (
              <Text
                fontSize="14px"
                lineHeight="16px"
                px="16px"
                py="12px"
                bg="error.primary"
                borderRadius="8px"
              >
                {message}
              </Text>
            )}
            <Flex mt={8}>
              <Avatar size="md" name={user ? user?.name : ""} />
              <Textarea
                data-testid="text"
                name="text"
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
                  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/407
                  // - Enhance Post Functionality: Add Image Attachment Feature.
                  icon={<FaImage />}
                  aria-label="Add image"
                  variant="ghost"
                  color="blue.400"
                  borderRadius="full"
                  _hover={{ bg: "whiteAlpha.200" }}
                />
                <PostButton isDisabled={isPostButtonDisabled} />
              </Flex>
            </Box>
          </form>
        </ModalBody>
      </ModalContent>
    </Modal>
  );
};
