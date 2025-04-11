"use client";

import { useColorModeValue } from "@/lib/components/ui/color-mode";
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
      disabled={isDisabled || pending}
      bg={useColorModeValue("gray", "white")}
      color={useColorModeValue("white", "black")}
      borderRadius="full"
      px={4}
      _hover={{ bg: "blue.primaryHover" }}
    >
      Post
    </Button>
  );
};
