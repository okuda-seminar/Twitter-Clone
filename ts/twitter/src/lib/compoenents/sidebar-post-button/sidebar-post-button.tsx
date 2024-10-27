"use client";

import React from "react";
import { Box, Button, IconButton, Tooltip } from "@chakra-ui/react";
import { useSideBarPostButton } from "./use-sidebar-post-button";
import { FaFeather } from "react-icons/fa";
import { PostModal } from "./post-modal";
import { SignInPromptModal } from "./sign-in-prompt-modal";
import { useSession } from "../session-context";

export const SideBarPostButton: React.FC = () => {
  const { session, user } = useSession();
  const {
    handlePostButtonClick,
    isPostModalOpen,
    onClosePostModal,
    isSignInPromptModalOpen,
    onCloseSignInPromptModal,
  } = useSideBarPostButton({ session, user });

  return (
    <Box>
      <Box>
        <Box display={{ base: "none", xl: "inline" }}>
          <Button
            bg="blue.primary"
            color="white"
            width="200px"
            size="lg"
            borderRadius="full"
            onClick={handlePostButtonClick}
          >
            Post
          </Button>
        </Box>
        <Tooltip label={"Post"} placement="bottom">
          <Box display={{ base: "inline", xl: "none" }}>
            <IconButton
              bg="blue.primary"
              aria-label={"Post"}
              icon={<FaFeather />}
              mx={4}
              borderRadius="full"
              onClick={handlePostButtonClick}
            />
          </Box>
        </Tooltip>
      </Box>

      <PostModal
        isOpen={isPostModalOpen}
        onClose={onClosePostModal}
        name={user?.name ?? ""}
      />

      <SignInPromptModal
        isOpen={isSignInPromptModalOpen}
        onClose={onCloseSignInPromptModal}
      />
    </Box>
  );
};
