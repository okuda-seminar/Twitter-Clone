import { createPost } from "@/lib/actions/create-post";
import { useRouter } from "next/navigation";
import { useState } from "react";

interface usePostModalReturn {
  handleCloseButtonClick: () => void;
  postText: string;
  handleTextAreaChange: (event: React.ChangeEvent<HTMLTextAreaElement>) => void;
  handlePostButtonClick: () => Promise<void>;
  isPostButtonDisabled: boolean;
}

export const usePostModal = (): usePostModalReturn => {
  const router = useRouter();
  const [postText, setPostText] = useState<string>("");

  const handleCloseButtonClick = () => {
    router.push("/home");
  };

  const handleTextAreaChange = (
    event: React.ChangeEvent<HTMLTextAreaElement>
  ) => {
    setPostText(event.target.value);
  };

  const handlePostButtonClick = async () => {
    try {
      const res = await createPost({
        user_id: `${process.env.NEXT_PUBLIC_USER_ID}`,
        text: postText,
      });

      console.log(res);

      setPostText("");
    } catch (err) {
      // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/477
      // - Display an error message to users if post creation fails.
      console.log(err);
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
