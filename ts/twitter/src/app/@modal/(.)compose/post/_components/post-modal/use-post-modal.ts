import { createPost } from "@/lib/actions/create-post";
import { useRouter } from "next/navigation";
import { useState } from "react";

interface usePostModalProps {
  isIntercepted: boolean;
}

interface usePostModalReturn {
  handleCloseButtonClick: () => void;
  postText: string;
  handleTextAreaChange: (event: React.ChangeEvent<HTMLTextAreaElement>) => void;
  handlePostButtonClick: () => Promise<void>;
  isPostButtonDisabled: boolean;
}

export const usePostModal = ({
  isIntercepted,
}: usePostModalProps): usePostModalReturn => {
  const router = useRouter();
  const [postText, setPostText] = useState<string>("");

  const handleCloseButtonClick = () => {
    isIntercepted ? router.back() : router.push("/home");
  };

  const handleTextAreaChange = (
    event: React.ChangeEvent<HTMLTextAreaElement>
  ) => {
    setPostText(event.target.value);
  };

  const handlePostButtonClick = async () => {
    const res = await createPost({
      user_id: `${process.env.NEXT_PUBLIC_USER_ID}`,
      text: postText,
    });

    if (res.ok) {
      console.log(res.value);
      setPostText("");
    } else {
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/477
      // - Display an error message to users if post creation fails.
      console.log(res.error);
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
