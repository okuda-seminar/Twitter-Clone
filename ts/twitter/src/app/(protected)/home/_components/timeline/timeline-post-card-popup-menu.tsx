"use client";

import {
  AnalyticsIcon,
  DeleteIcon,
  EmbeddingIcon,
  HighlightIcon,
  ListIcon,
  PinIcon,
  ReplyIcon,
  RequestIcon,
  ThreeDotsIcon,
} from "@/lib/components/icons";
import { useColorModeValue } from "@/lib/components/ui/color-mode";
import { Flex, IconButton, Menu, Portal, Text } from "@chakra-ui/react";

const menuItems = [
  { value: "delete", icon: DeleteIcon, text: "Delete", color: "red.400" },
  { value: "pin", icon: PinIcon, text: "Pin to your profile" },
  {
    value: "highlight",
    icon: HighlightIcon,
    text: "Highlight on your profile",
  },
  { value: "list", icon: ListIcon, text: "Add/remove from Lists" },
  { value: "reply", icon: ReplyIcon, text: "Change who can reply" },
  { value: "engagements", icon: AnalyticsIcon, text: "View post engagements" },
  { value: "embedding", icon: EmbeddingIcon, text: "Embed post" },
  { value: "analytics", icon: AnalyticsIcon, text: "View post analytics" },
  { value: "request", icon: RequestIcon, text: "Request community note" },
];

export const TimelinePostCardPopupMenu: React.FC<
  Omit<Menu.RootProps, "children">
> = (props) => {
  return (
    <Menu.Root positioning={{ placement: "left-start" }} {...props}>
      <Menu.Trigger asChild>
        {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/829
        - Implement the UI that display more character while hovering. */}
        <IconButton
          minW={0}
          bg="transparent"
          borderRadius="full"
          aria-label="More options"
          color={useColorModeValue("black", "gray.500")}
          _groupHover={{ bg: "blue.500_10", color: "blue.400" }}
        >
          <ThreeDotsIcon />
        </IconButton>
      </Menu.Trigger>

      <Portal>
        <Menu.Positioner>
          <Menu.Content
            backgroundColor={useColorModeValue("white", "black")}
            width="100%"
            borderRadius="md"
          >
            {menuItems.map((item) => (
              <Menu.Item key={item.value} value={item.value} color={item.color}>
                <Flex align="center" p="8px" w="100%">
                  <item.icon boxSize="20px" style={{ marginRight: "8px" }} />
                  <Text>{item.text}</Text>
                </Flex>
              </Menu.Item>
            ))}
          </Menu.Content>
        </Menu.Positioner>
      </Portal>
    </Menu.Root>
  );
};
