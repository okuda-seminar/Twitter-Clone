import { Box, Flex, IconButton, Text, Tooltip } from "@chakra-ui/react";
import Link from "next/link";
import type React from "react";

interface IconButtonWithLinkProps {
  url: string;
  tooltipText: string;
  ariaLabel: string;
  icon: React.ReactElement;
}

export const IconButtonWithLink: React.FC<IconButtonWithLinkProps> = ({
  url,
  tooltipText,
  ariaLabel,
  icon,
}) => {
  return (
    <Link href={url}>
      <Flex alignItems="center">
        <Tooltip label={tooltipText} placement="bottom">
          <Box display={{ base: "inline", xl: "none" }}>
            <IconButton aria-label={ariaLabel} icon={icon} mx={4} />
          </Box>
        </Tooltip>
        <Box display={{ base: "none", xl: "flex" }}>
          <IconButton aria-label={ariaLabel} icon={icon} mx={4} />
          <Text fontWeight="bold">{ariaLabel}</Text>
        </Box>
      </Flex>
    </Link>
  );
};
