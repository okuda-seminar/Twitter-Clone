"use client";

import { QuoteRepostIcon, RepostIcon } from "@/lib/components/icons";
import { useColorModeValue } from "@/lib/components/ui/color-mode";
import { Flex, Menu, Portal, Text } from "@chakra-ui/react";

interface RepostQuoteMenuProps {
  onRepostClick: () => void;
  onQuoteClick: () => void;
  children: React.ReactNode;
  open?: boolean;
  onOpenChange?: (details: { open: boolean }) => void;
}

export const RepostQuoteMenu: React.FC<RepostQuoteMenuProps> = ({
  onRepostClick,
  onQuoteClick,
  children,
  open,
  onOpenChange,
}) => {
  return (
    <Menu.Root
      positioning={{ placement: "left-start" }}
      open={open}
      onOpenChange={onOpenChange}
    >
      <Menu.Trigger asChild>{children}</Menu.Trigger>

      <Portal>
        <Menu.Positioner>
          <Menu.Content
            backgroundColor={useColorModeValue("white", "black")}
            width="100%"
            borderRadius="xl"
          >
            <Menu.Item value="repost" onClick={onRepostClick}>
              <Flex align="center" p="8px" w="100%">
                <RepostIcon boxSize="20px" style={{ marginRight: "8px" }} />
                <Text fontWeight="bold">Repost</Text>
              </Flex>
            </Menu.Item>
            <Menu.Item value="quote" onClick={onQuoteClick}>
              <Flex align="center" p="8px" w="100%">
                <QuoteRepostIcon
                  boxSize="20px"
                  style={{ marginRight: "8px" }}
                />
                <Text fontWeight="bold">Quote</Text>
              </Flex>
            </Menu.Item>
          </Menu.Content>
        </Menu.Positioner>
      </Portal>
    </Menu.Root>
  );
};
