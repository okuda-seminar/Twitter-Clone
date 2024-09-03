"use client";
import React from "react";
import { Box, useDisclosure } from "@chakra-ui/react";
import PostModal from "./postmodal";
import PostButton from "./postbutton";
import SignInPromptModal from "./signinpromptmodal"
import { useSession } from "../auth/sessioncontext";

const Posts = () => {
  const { isOpen, onOpen, onClose } = useDisclosure();
  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/417 - Refactor modal state management using enum for improved clarity.

  const { session, user } = useSession();

  return (
    <Box>
      <PostButton onOpen={onOpen} />
      {session && user ? (
        <PostModal
          isOpen={isOpen}
          onClose={onClose}
          name={user.name}
          id={user.id}
        />
      ) : (
        <SignInPromptModal isOpen={isOpen} onClose={onClose} />
      )}
    </Box>
  );
};

export default Posts;
