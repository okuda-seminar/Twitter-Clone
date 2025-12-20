import { createQuoteRepost } from "@/lib/actions/create-quote-repost";
import { useComposeModal } from "@/lib/components/compose-modal-context";
import { useTimeline } from "@/lib/components/timeline-context";
import { toaster } from "@/lib/components/ui/toaster";
import { ERROR_MESSAGES } from "@/lib/constants/error-messages";
import type { User } from "@/lib/models/user";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { createPost } from "#src/lib/actions/create-post";

const generateTempId = () =>
  `temp-${Date.now()}-${Math.random().toString(36).substring(2, 11)}`;

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
  quotedPost: ReturnType<typeof useComposeModal>["quotedPost"];
  isLoadingQuotedPost: boolean;
}

export const usePostModal = ({
  isIntercepted,
  user,
}: UsePostModalProps): UsePostModalReturn => {
  const router = useRouter();
  const { quotedPost, clearModalState } = useComposeModal();
  const {
    addOptimisticQuoteRepost,
    removeOptimisticQuoteRepost,
    replaceOptimisticWithReal,
  } = useTimeline();
  const [postText, setPostText] = useState<string>("");
  const isLoadingQuotedPost = false; // Always false, data is instantly available

  const handleCloseButtonClick = () => {
    clearModalState();
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
      // biome-ignore lint/style/noNonNullAssertion: user is guaranteed to exist in this context.
      const userId = user!.id;
      const text = formData.get("text") as string;

      // If quoting a post, use createQuoteRepost
      if (quotedPost) {
        const tempId = generateTempId();
        const optimisticQuoteRepost = {
          type: "quoteRepost" as const,
          id: tempId,
          tempId: tempId,
          authorId: userId,
          parentPostId: { UUID: quotedPost.id, Valid: true },
          text,
          createdAt: new Date().toISOString(),
          isOptimistic: true,
        };

        // Add optimistic item immediately
        addOptimisticQuoteRepost(optimisticQuoteRepost);

        try {
          const res = await createQuoteRepost(userId, {
            post_id: quotedPost.id,
            text,
          });

          if (!res.ok) {
            // Rollback optimistic update
            removeOptimisticQuoteRepost(tempId);

            // Show error toast
            toaster.create({
              title: "Failed to create quote repost",
              description: ERROR_MESSAGES.POST_CREATION_ERROR,
              type: "error",
              duration: 5000,
            });

            return ERROR_MESSAGES.POST_CREATION_ERROR;
          }

          // Replace optimistic with real data
          replaceOptimisticWithReal(tempId, {
            type: "quoteRepost",
            id: res.value.id,
            authorId: res.value.authorId,
            parentPostId: res.value.parentPostId,
            text: res.value.text,
            createdAt: res.value.createdAt,
          });
        } catch (error) {
          // Rollback on network error
          removeOptimisticQuoteRepost(tempId);

          toaster.create({
            title: "Network error",
            description: ERROR_MESSAGES.POST_CREATION_ERROR,
            type: "error",
            duration: 5000,
          });

          return ERROR_MESSAGES.POST_CREATION_ERROR;
        }
      } else {
        const res = await createPost(userId, { text });

        if (!res.ok) {
          return ERROR_MESSAGES.POST_CREATION_ERROR;
        }
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
    quotedPost,
    isLoadingQuotedPost,
  };
};
