import React from "react";
import { Box } from "@chakra-ui/react";

export default function Sidebar() {
  return (
    <Box>
      <Box
        as="img"
        src="https://help.twitter.com/content/dam/help-twitter/brand/logo.png"
        alt="Twitter Logo"
        width="50"
        height="50"
        borderRadius="full" // 丸みを持たせる
        boxShadow="md" // 影をつける
      />
    </Box>
  );
}
