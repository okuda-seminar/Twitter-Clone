import React from "react";
import { IconButton, Tooltip } from "@chakra-ui/react";
import { IoIosSettings } from "react-icons/io";

export const SettingsButton = () => {
  return (
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
  );
};
