import { Flex, IconButton, Link, Text, Tooltip } from "@chakra-ui/react";
import NextLink from "next/link";
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
    <Link as={NextLink} href={url} w="100%">
      <Flex alignItems="center" p="12px">
        <Tooltip
          label={tooltipText}
          placement="bottom"
          display={{ base: "inline", xl: "none" }}
        >
          <IconButton aria-label={ariaLabel} icon={icon} />
        </Tooltip>
        <Text
          fontWeight="bold"
          ml="20px"
          display={{ base: "none", xl: "flex" }}
        >
          {ariaLabel}
        </Text>
      </Flex>
    </Link>
  );
};
