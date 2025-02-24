"use client";

import { Button } from "@chakra-ui/react";
import { useFormStatus } from "react-dom";

export interface PostButtonProps {
  isDisabled: boolean;
}

export const PostButton = ({ isDisabled }: PostButtonProps) => {
  const { pending } = useFormStatus();

  return (
    <Button
      data-testid="post-button"
      type="submit"
      isDisabled={isDisabled || pending}
      bg="blue.primary"
      color="white"
      borderRadius="full"
      px={4}
      _hover={{ bg: "blue.primaryHover" }}
    >
      Post
    </Button>
  );
};
