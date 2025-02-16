"use client";

import { Box, Button } from "@chakra-ui/react";
import { useEffect } from "react";

export default function ErrorBoundary({
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
