import { Box } from "@chakra-ui/react";
import { HomeIcon } from "@heroicons/react/solid";
import SidebarMenuItem from "./SidebarMenuItem";

export default function Sidebar() {
  return (
    <Box>
      <Box
        as="img"
        src="https://help.twitter.com/content/dam/help-twitter/brand/logo.png"
        alt="Twitter Logo"
        width="50"
        height="50"
        borderRadius="full" // 丸みを持たせる
        boxShadow="md" // 影をつける
        backgroundColor={"blue.600"}
      />
      <SidebarMenuItem text="Home" Icon={HomeIcon} active={true} />
    </Box>
  );
}
