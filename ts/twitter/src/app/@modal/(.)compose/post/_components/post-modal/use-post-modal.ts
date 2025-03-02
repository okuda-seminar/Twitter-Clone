import { ERROR_MESSAGES } from "@/lib/constants/error-messages";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { createPost } from "#src/lib/actions/create-post";

interface UsePostModalProps {
  isIntercepted: boolean;
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
        user_id: `${process.env.NEXT_PUBLIC_USER_ID}`,
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
