"use client";

import {
  Box,
  Link as ChakraLink,
  Flex,
  IconButton,
  Menu,
  Portal,
  Text,
  useBreakpointValue,
} from "@chakra-ui/react";
import NextLink from "next/link";
import {
  AdsIcon,
  MonetizationIcon,
  MoreIcon,
  SettingsIcon,
  SpaceIcon,
} from "../icons";
import { useColorModeValue } from "../ui/color-mode";
import { Tooltip } from "../ui/tooltip";

export const MorePopup: React.FC<Omit<Menu.RootProps, "children">> = (
  props,
) => {
  const isTooltipDisabled = useBreakpointValue({ base: false, xl: true });
  const menuItems = [
    {
      label: "Monetization",
      icon: <MonetizationIcon />,
    },
    {
      label: "Ads",
      icon: <AdsIcon />,
    },
    {
      label: "Create your Space",
      icon: <SpaceIcon />,
    },
  ];

  return (
    <Box position="relative">
      <Menu.Root {...props}>
        <Menu.Trigger asChild>
          <Flex
            as="button"
            alignItems="center"
            p="12px"
            width="auto"
            _hover={{
              bg: useColorModeValue("gray.200", "gray.900"),
              "& button": {
                bg: useColorModeValue("gray.200", "gray.900"),
                transition: "none",
              },
            }}
            focusRing="none"
            focusVisibleRing="outside"
            borderRadius="full"
          >
            <Tooltip content="More" disabled={isTooltipDisabled}>
              <IconButton
                aria-label="More"
                color={useColorModeValue("black", "white")}
                bg={useColorModeValue("white", "black")}
                transition="none"
                inert
              >
                <MoreIcon />
              </IconButton>
            </Tooltip>
            <Text
              fontWeight="bold"
              ml="20px"
              display={{ base: "none", xl: "flex" }}
            >
              More
            </Text>
          </Flex>
        </Menu.Trigger>
        <Portal>
          <Menu.Positioner
            backgroundColor={useColorModeValue("white", "black")}
          >
            <Menu.Content>
              {menuItems.map((item) => (
                <Menu.Item value={item.label} key={item.label}>
                  <Flex alignItems="center" p="12px" w="100%">
                    <Tooltip
                      content={item.label}
                      positioning={{ placement: "bottom" }}
                      disabled={isTooltipDisabled}
                    >
                      {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/739 
                      - Replace default Focus Ring with Focus Visible Ring. */}
                      <IconButton
                        aria-label={item.label}
                        color={useColorModeValue("black", "white")}
                        bg={useColorModeValue("white", "black")}
                      >
                        {item.icon}
                      </IconButton>
                    </Tooltip>
                    <Text
                      fontWeight="bold"
                      ml="20px"
                      display={{ base: "none", xl: "flex" }}
                    >
                      {item.label}
                    </Text>
                  </Flex>
                </Menu.Item>
              ))}
              <Menu.Item
                value="Settings and privacy"
                key="settings-privacy-link"
              >
                <ChakraLink asChild _hover={{ textDecoration: "none" }}>
                  <NextLink href="/settings" scroll={false}>
                    <Flex alignItems="center" p="12px" w="100%">
                      <Tooltip
                        content="Settings and privacy"
                        positioning={{ placement: "bottom" }}
                        disabled={isTooltipDisabled}
                      >
                        <IconButton
                          aria-label="Settings and privacy"
                          color={useColorModeValue("black", "white")}
                          bg={useColorModeValue("white", "black")}
                        >
                          <SettingsIcon />
                        </IconButton>
                      </Tooltip>
                      <Text
                        fontWeight="bold"
                        ml="20px"
                        display={{ base: "none", xl: "flex" }}
                      >
                        Settings and privacy
                      </Text>
                    </Flex>
                  </NextLink>
                </ChakraLink>
              </Menu.Item>
            </Menu.Content>
          </Menu.Positioner>
        </Portal>
      </Menu.Root>
    </Box>
  );
};
