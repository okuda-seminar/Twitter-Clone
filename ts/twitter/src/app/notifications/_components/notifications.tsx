import { Box, Flex, IconButton, Tooltip } from "@chakra-ui/react";
import type React from "react";
import { IoIosSettings } from "react-icons/io";
import { NotificationsTabBar } from "./notifications-tab-bar";

export const Notifications: React.FC = () => {
  return (
    <Box>
      <Flex>
        <Box mx="12px" mt="8px" gap="4" fontSize="lg">
          Notifications
        </Box>
        <Tooltip label="Settings" placement="bottom" size="sm">
          <IconButton
            bg="transparent"
            aria-label="Settings"
            icon={<IoIosSettings />}
            mx={4}
            size="lg"
            borderRadius="full"
            ml="auto"
          />
        </Tooltip>
      </Flex>
      <NotificationsTabBar />
    </Box>
  );
};
