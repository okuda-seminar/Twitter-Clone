"use client";

import React from "react";
import { Box } from "@chakra-ui/react";
import { useSession } from "../auth/session-context";
import PostButton from "./_components/post-button";
import PostModal from "./_components/post-modal";
import SignInPromptModal from "./_components/sign-in-prompt-modal";

enum ModalState {
  Closed,
  PostModalOpen,
  SignInPromptOpen,
}

const Posts = () => {
  const [modalState, setModalState] = React.useState<ModalState>(
    ModalState.Closed
  );
  const { session, user } = useSession();

  const openModal = () => {
    if (session && user) {
      setModalState(ModalState.PostModalOpen);
    } else {
      setModalState(ModalState.SignInPromptOpen);
    }
  };

  const closeModal = () => {
    setModalState(ModalState.Closed);
  };

  return (
    <Box>
      <PostButton onOpen={openModal} />
      <PostModal
        isOpen={modalState === ModalState.PostModalOpen}
        onClose={closeModal}
        name={user?.name ?? ""}
        id={user?.id ?? ""}
      />
      <SignInPromptModal
        isOpen={modalState === ModalState.SignInPromptOpen}
        onClose={closeModal}
      />
    </Box>
  );
};

export default Posts;
