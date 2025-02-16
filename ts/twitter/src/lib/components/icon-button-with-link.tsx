import { Box, Flex, IconButton, Text, Tooltip } from "@chakra-ui/react";
import Link from "next/link";
import type React from "react";

interface Props {
  url: string;
  tooltipText: string;
  ariaLabel: string;
  icon: React.ReactElement;
}

export const IconButtonWithLink: React.FC<Props> = (props) => {
  return (
    <Link href={props.url}>
      <Flex alignItems="center">
        <Tooltip label={props.tooltipText} placement="bottom">
          <Box display={{ base: "inline", xl: "none" }}>
            <IconButton aria-label={props.ariaLabel} icon={props.icon} mx={4} />
          </Box>
        </Tooltip>
        <Box display={{ base: "none", xl: "flex" }}>
          <IconButton aria-label={props.ariaLabel} icon={props.icon} mx={4} />
          <Text fontWeight="bold">{props.ariaLabel}</Text>
        </Box>
      </Flex>
    </Link>
  );
};
