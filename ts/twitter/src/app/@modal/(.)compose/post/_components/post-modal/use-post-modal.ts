import { createPost } from "@/lib/actions/create-post";
import { ERROR_MESSAGES } from "@/lib/constants/error-messages";
import type { User } from "@/lib/models/user";
import { useRouter } from "next/navigation";
import { useState } from "react";

interface UsePostModalProps {
  isIntercepted: boolean;
  user: User | undefined;
}

interface UsePostModalReturn {
  handleCloseButtonClick: () => void;
  postText: string;
  handleTextAreaChange: (event: React.ChangeEvent<HTMLTextAreaElement>) => void;
  handlePostButtonClick: (
    currentMessage: string | undefined,
    formData: FormData,
  ) => Promise<string | undefined>;
  isPostButtonDisabled: boolean;
}

export const usePostModal = ({
  isIntercepted,
  user,
}: UsePostModalProps): UsePostModalReturn => {
  const router = useRouter();
  const [postText, setPostText] = useState<string>("");

  const handleCloseButtonClick = () => {
    isIntercepted ? router.back() : router.push("/home");
  };

  const handleTextAreaChange = (
    event: React.ChangeEvent<HTMLTextAreaElement>,
  ) => {
    setPostText(event.target.value);
  };

  // currentMessage should be passed as the first argument due to the useFormState specification.
  const handlePostButtonClick = async (
    currentMessage: string | undefined,
    formData: FormData,
  ) => {
    try {
      const res = await createPost({
        // biome-ignore lint/style/noNonNullAssertion: user is guaranteed to exist in this context.
        user_id: user!.id,
        text: formData.get("text") as string,
      });

      if (!res.ok) {
        return ERROR_MESSAGES.POST_CREATION_ERROR;
      }

      setPostText("");
      handleCloseButtonClick();
    } catch (error) {
      return ERROR_MESSAGES.POST_CREATION_ERROR;
    }
  };

  const isPostButtonDisabled = postText.trim() === "";

  return {
    handleCloseButtonClick,
    postText,
    handleTextAreaChange,
    handlePostButtonClick,
    isPostButtonDisabled,
  };
};
