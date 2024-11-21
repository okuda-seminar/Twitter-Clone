"use client";

import { useEffect } from "react";
import { Box, Button } from "@chakra-ui/react";

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    console.error(error);
  }, [error]);

  return (
    <Box>
      <Box>Something is wrong.</Box>
      <Button onClick={() => reset()}>Try again</Button>
    </Box>
  );
}
