import { IconButton, Tooltip } from "@chakra-ui/react";
import type React from "react";
import { IoIosSettings } from "react-icons/io";

export const SettingsButton: React.FC = () => {
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
