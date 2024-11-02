import { useDisclosure } from "@chakra-ui/react";
import { User } from "../session-context";
import { useRouter } from "next/navigation";

interface useSideBarPostButtonProps {
  session: boolean;
  user: User | null;
}

interface useSideBarPostButtonReturn {
  handlePostButtonClick: () => void;
  isSignInPromptModalOpen: boolean;
  onCloseSignInPromptModal: () => void;
}

export const useSideBarPostButton = ({
  session,
  user,
}: useSideBarPostButtonProps): useSideBarPostButtonReturn => {
  const router = useRouter();
  const {
    isOpen: isSignInPromptModalOpen,
    onOpen: onOpenSignInPromptModal,
    onClose: onCloseSignInPromptModal,
  } = useDisclosure();

  const isAuthenticated = session && user;

  const handlePostButtonClick = () => {
    isAuthenticated ? router.push("/compose/post") : onOpenSignInPromptModal();
  };

  return {
    handlePostButtonClick,
    isSignInPromptModalOpen,
    onCloseSignInPromptModal,
  };
};
