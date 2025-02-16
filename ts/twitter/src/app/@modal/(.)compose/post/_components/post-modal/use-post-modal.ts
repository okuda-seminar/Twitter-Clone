import { createPost } from "@/lib/actions/create-post";
import { useRouter } from "next/navigation";
import { useState } from "react";

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
    const message =
      "Something went wrong, but don't fret - let's give it another shot.";
    try {
      const res = await createPost({
        user_id: `${process.env.NEXT_PUBLIC_USER_ID}`,
        text: formData.get("text") as string,
      });

      if (!res.ok) {
        return message;
      }

      setPostText("");
      handleCloseButtonClick();
    } catch (error) {
      return message;
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
