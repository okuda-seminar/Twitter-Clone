import React from "react";
import {
  Modal,
  ModalOverlay,
  ModalContent,
  ModalHeader,
  ModalFooter,
  ModalBody,
  ModalCloseButton,
  Text,
} from "@chakra-ui/react";

interface SignInPromptModalProps {
  isOpen: boolean;
  onClose: () => void;
}

const SignInPromptModal: React.FC<SignInPromptModalProps> = ({
  isOpen,
  onClose,
}) => {
  return (
    <Modal isOpen={isOpen} onClose={onClose}>
      <ModalOverlay />
      <ModalContent>
        <ModalHeader>Sign In Required</ModalHeader>
        <ModalCloseButton />
        <ModalBody>
          <Text>You need to sign in to post.</Text>
        </ModalBody>
        <ModalFooter></ModalFooter>
      </ModalContent>
    </Modal>
  );
};

export default SignInPromptModal;
