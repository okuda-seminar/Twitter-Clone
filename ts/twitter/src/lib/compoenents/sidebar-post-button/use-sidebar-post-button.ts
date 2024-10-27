import { useDisclosure } from "@chakra-ui/react";
import { User } from "../session-context";

interface useSideBarPostButtonProps {
  session: boolean;
  user: User | null;
}

interface useSideBarPostButtonReturn {
  handlePostButtonClick: () => void;
  isPostModalOpen: boolean;
  onClosePostModal: () => void;
  isSignInPromptModalOpen: boolean;
  onCloseSignInPromptModal: () => void;
}

export const useSideBarPostButton = ({
  session,
  user,
}: useSideBarPostButtonProps): useSideBarPostButtonReturn => {
  const {
    isOpen: isPostModalOpen,
    onOpen: onOpenPostModal,
    onClose: onClosePostModal,
  } = useDisclosure();

  const {
    isOpen: isSignInPromptModalOpen,
    onOpen: onOpenSignInPromptModal,
    onClose: onCloseSignInPromptModal,
  } = useDisclosure();

  const isAuthenticated = session && user;

  const handlePostButtonClick = () => {
    isAuthenticated ? onOpenPostModal() : onOpenSignInPromptModal();
  };

  return {
    handlePostButtonClick,
    isPostModalOpen,
    onClosePostModal,
    isSignInPromptModalOpen,
    onCloseSignInPromptModal,
  };
};
