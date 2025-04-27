"use client";

import {
  Box,
  Flex,
  IconButton,
  Menu,
  Portal,
  Text,
  useBreakpointValue,
} from "@chakra-ui/react";
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
    {
      label: "Settings and privacy",
      icon: <SettingsIcon />,
    },
  ];

  return (
    <Box position="relative">
      <Menu.Root {...props}>
        <Menu.Trigger asChild>
          <Flex alignItems="center" p="12px" width="auto">
            <Tooltip content="More" disabled={isTooltipDisabled}>
              <IconButton
                aria-label="More"
                color={useColorModeValue("black", "white")}
                bg={useColorModeValue("white", "black")}
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
            </Menu.Content>
          </Menu.Positioner>
        </Portal>
      </Menu.Root>
    </Box>
  );
};
