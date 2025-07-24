import {
  Link as ChakraLink,
  Flex,
  IconButton,
  Text,
  useBreakpointValue,
} from "@chakra-ui/react";
import NextLink from "next/link";
import type React from "react";
import { useColorModeValue } from "../ui/color-mode";
import { Tooltip } from "../ui/tooltip";

interface IconButtonWithLinkProps {
  url: string;
  tooltipContent: string;
  ariaLabel: string;
  icon: React.ReactElement;
}

export const IconButtonWithLink: React.FC<IconButtonWithLinkProps> = ({
  url,
  tooltipContent,
  ariaLabel,
  icon,
}) => {
  const isTooltipDisabled = useBreakpointValue({ base: false, xl: true });
  return (
    <ChakraLink
      asChild
      focusRing="none"
      focusVisibleRing="outside"
      _hover={{
        bg: useColorModeValue("gray.200", "gray.900"),
        textDecoration: "none",
        "& button": {
          bg: useColorModeValue("gray.200", "gray.900"),
          transition: "none",
        },
      }}
      borderRadius="full"
    >
      <NextLink href={url}>
        <Flex alignItems="center" p="12px" w="100%">
          <Tooltip
            content={tooltipContent}
            positioning={{ placement: "bottom" }}
            disabled={isTooltipDisabled}
          >
            <IconButton
              aria-label={ariaLabel}
              color={useColorModeValue("black", "white")}
              bg={useColorModeValue("white", "black")}
              transition="none"
              inert
            >
              {icon}
            </IconButton>
          </Tooltip>
          <Text
            fontWeight="bold"
            ml="20px"
            display={{ base: "none", xl: "flex" }}
          >
            {ariaLabel}
          </Text>
        </Flex>
      </NextLink>
    </ChakraLink>
  );
};
