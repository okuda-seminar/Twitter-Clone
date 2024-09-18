import React from "react";
import { IconButton, Tooltip, Flex, Box, Text } from "@chakra-ui/react";
import Link from "next/link";

interface Props {
  url: string;
  tooltipText: string;
  ariaLabel: string;
  icon: React.ReactElement;
}

const IconButtonWithLink: React.FC<Props> = (props) => {
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

export default IconButtonWithLink;
