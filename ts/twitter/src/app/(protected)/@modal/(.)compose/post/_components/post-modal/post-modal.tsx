"use client";

import { useAuth } from "@/lib/components/auth-context";
import { MediaIcon } from "@/lib/components/icons";
import {
  Avatar,
  Box,
  CloseButton,
  Dialog,
  Flex,
  HStack,
  IconButton,
  Text,
  Textarea,
} from "@chakra-ui/react";
import type React from "react";
import { useActionState, useRef } from "react";
import { PostButton } from "../post-button/post-button";
import { usePostModal } from "./use-post-modal";

interface PostModalProps {
  isIntercepted: boolean;
}

export const PostModal: React.FC<PostModalProps> = ({ isIntercepted }) => {
  const { user } = useAuth();
  const {
    handleCloseButtonClick,
    postText,
    handleTextAreaChange,
    handlePostButtonClick,
    isPostButtonDisabled,
    quotedPost,
  } = usePostModal({
    isIntercepted,
    user,
  });

  const [message, formAction] = useActionState(
    handlePostButtonClick,
    undefined,
  );
  const textAreaRef = useRef<HTMLTextAreaElement>(null);
  if (textAreaRef.current) textAreaRef.current.focus();

  return (
    <Dialog.Root
      initialFocusEl={() => textAreaRef.current}
      open={true}
      size="md"
      onInteractOutside={() => {
        handleCloseButtonClick();
      }}
    >
      {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/664
    - Adjust position of post modal when opened. */}
      <Dialog.Backdrop />
      <Dialog.Positioner>
        <Dialog.Content
          bg="black"
          color="white"
          w="400px"
          minW="550px"
          top="50px"
        >
          <Dialog.CloseTrigger
            asChild
            color="white"
            position="absolute"
            top="8px"
            right="auto"
            left="8px"
            onClick={handleCloseButtonClick}
            borderRadius="full"
            p={2}
            _hover={{
              background: "gray.500",
            }}
          >
            <CloseButton />
          </Dialog.CloseTrigger>
          <Dialog.Body pt="30px" pb={4}>
            <form action={formAction}>
              {message !== undefined && (
                <Text
                  mt="40px"
                  fontSize="14px"
                  lineHeight="16px"
                  px="16px"
                  py="12px"
                  bg="error.primary"
                  borderRadius="8px"
                  color="white"
                >
                  {message}
                </Text>
              )}
              <Flex mt={8}>
                <Avatar.Root size="md" mr={3}>
                  <Avatar.Fallback name={user ? user?.displayName : ""} />
                </Avatar.Root>
                <Box flex="1">
                  <Textarea
                    data-testid="text"
                    name="text"
                    ref={textAreaRef}
                    value={postText}
                    onChange={handleTextAreaChange}
                    placeholder="What is happening?!"
                    border="none"
                    resize="none"
                    minH="100px"
                    _focus={{ boxShadow: "none" }}
                    fontSize="xl"
                  />

                  {quotedPost && (
                    <Box
                      mt={4}
                      p={3}
                      borderWidth="1px"
                      borderColor="gray.600"
                      borderRadius="xl"
                    >
                      <HStack gap={2} mb={2}>
                        <Avatar.Root size="2xs">
                          <Avatar.Fallback name={quotedPost.authorId} />
                        </Avatar.Root>
                        <Text fontWeight="bold" fontSize="sm">
                          name
                        </Text>
                        <Text color="gray.500" fontSize="sm">
                          @username
                        </Text>
                      </HStack>
                      <Text fontSize="sm" whiteSpace="pre-wrap">
                        {quotedPost.text}
                      </Text>
                    </Box>
                  )}
                </Box>
              </Flex>
              <Box borderTop="1px solid" borderColor="gray.600" mt={4} pt={4}>
                <Flex justifyContent="space-between">
                  <IconButton
                    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/407
                    // - Enhance Post Functionality: Add Image Attachment Feature.
                    aria-label="Add image"
                    variant="ghost"
                    color="blue.400"
                    borderRadius="full"
                    _hover={{ bg: "whiteAlpha.200" }}
                  >
                    <MediaIcon />
                  </IconButton>
                  <PostButton isDisabled={isPostButtonDisabled} />
                </Flex>
              </Box>
            </form>
          </Dialog.Body>
        </Dialog.Content>
      </Dialog.Positioner>
    </Dialog.Root>
  );
};
