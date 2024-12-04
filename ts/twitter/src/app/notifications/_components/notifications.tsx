import React from "react";
import { Box, Flex } from "@chakra-ui/react";
import { SettingsButton } from "@/lib/components/settings-button";
import { NotificationsTabBar } from "./notifications-tab-bar";

export const Notifications: React.FC = () => {
  return (
    <Box>
      <Flex>
        <Box mx="12px" mt="8px" gap="4" fontSize="lg">
          Notifications
        </Box>
        <SettingsButton />
      </Flex>
      <NotificationsTabBar />
    </Box>
  );
};
