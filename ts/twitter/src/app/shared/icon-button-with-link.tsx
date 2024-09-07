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
      <Tooltip label={props.tooltipText} placement="bottom">
        {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/392 - Show tooltips on sidebar icons only when window size isn't large enough and icon labels are hidden. */}

        <Flex alignItems="center">
          <IconButton aria-label={props.ariaLabel} icon={props.icon} mx={4} />
          <Box display={{ base: "none", xl: "inline" }}>
            <Text fontWeight="bold">{props.ariaLabel}</Text>
          </Box>
        </Flex>
      </Tooltip>
    </Link>
  );
};

export default IconButtonWithLink;
