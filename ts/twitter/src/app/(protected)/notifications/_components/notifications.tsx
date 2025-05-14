"use client";

import { SettingsIcon } from "@/lib/components/icons";
import { useColorModeValue } from "@/lib/components/ui/color-mode";
import { Tooltip } from "@/lib/components/ui/tooltip";
import { Box, Flex, IconButton } from "@chakra-ui/react";
import type React from "react";
import { NotificationsTabBar } from "./notifications-tab-bar";

export const Notifications: React.FC = () => {
  return (
    <Box>
      <Flex>
        <Box mx="12px" mt="8px" gap="4" fontSize="lg">
          Notifications
        </Box>
        <Tooltip content="Settings" positioning={{ placement: "bottom" }}>
          <IconButton
            bg="transparent"
            color={useColorModeValue("black", "white")}
            aria-label="Settings"
            mx={2}
            size="lg"
            borderRadius="full"
            ml="auto"
          >
            <SettingsIcon />
          </IconButton>
        </Tooltip>
      </Flex>
      <NotificationsTabBar />
    </Box>
  );
};
