"use client";

import {
  AnalyticsIcon,
  BlockIcon,
  DeleteIcon,
  EditIcon,
  EmbeddingIcon,
  FlagIcon,
  HiddenRepliesIcon,
  HighlightIcon,
  ListIcon,
  MuteIcon,
  PinIcon,
  ReplyIcon,
  RequestIcon,
  ThreeDotsIcon,
  UnfollowIcon,
} from "@/lib/components/icons";
import { useColorModeValue } from "@/lib/components/ui/color-mode";
import { Flex, IconButton, Menu, Portal, Text } from "@chakra-ui/react";
import type { IconProps } from "@chakra-ui/react";

const myPostMenuItems: MenuItem[] = [
  { value: "delete", icon: DeleteIcon, text: "Delete", color: "red.400" },
  { value: "edit", icon: EditIcon, text: "Edit" },
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
  {
    value: "hidden-replies",
    icon: HiddenRepliesIcon,
    text: "View hidden replies",
  },
  { value: "request", icon: RequestIcon, text: "Request community note" },
];

const otherPostMenuItems: MenuItem[] = [
  { value: "unfollow", icon: UnfollowIcon, text: "Unfollow @username" },
  { value: "list", icon: ListIcon, text: "Add/remove from Lists" },
  { value: "mute", icon: MuteIcon, text: "Mute" },
  { value: "block", icon: BlockIcon, text: "Block @username" },
  { value: "engagements", icon: AnalyticsIcon, text: "View post engagements" },
  { value: "embedding", icon: EmbeddingIcon, text: "Embed post" },
  { value: "report", icon: FlagIcon, text: "Report post" },
  { value: "request", icon: RequestIcon, text: "Request Community Note" },
];

interface TimelinePostCardPopupMenuProps
  extends Omit<Menu.RootProps, "children"> {
  isMyPost: boolean;
}

type MenuItem = {
  value: string;
  icon: React.ComponentType<IconProps>;
  text: string;
  color?: string;
};

export const TimelinePostCardPopupMenu: React.FC<
  TimelinePostCardPopupMenuProps
> = ({ isMyPost, ...props }) => {
  const menuItems = isMyPost ? myPostMenuItems : otherPostMenuItems;
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
