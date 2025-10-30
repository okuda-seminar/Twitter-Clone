import { Box, Button } from "@chakra-ui/react";
import type React from "react";

interface NewPostsBannerProps {
  count: number;
  onLoadNewPosts: () => void;
}

export const NewPostsBanner: React.FC<NewPostsBannerProps> = ({
  count,
  onLoadNewPosts,
}) => {
  if (count === 0) return null;

  return (
    <Box
      width="100%"
      bg="transparent"
      color="blue.primary"
      py="1"
      px="4"
      textAlign="center"
      cursor="pointer"
      onClick={onLoadNewPosts}
      borderBottomWidth="1px"
    >
      <Button
        variant="ghost"
        color="blue.primary"
        _hover={{ bg: "transparent" }}
        width="100%"
        fontWeight="semibold"
      >
        {count === 1 ? "New post" : `Show ${count} posts`}
      </Button>
    </Box>
  );
};
