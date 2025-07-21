"use client";

import { useColorModeValue } from "@/lib/components/ui/color-mode";
import type { TimelineItem } from "@/lib/models/post";
import {
  Avatar,
  Box,
  Flex,
  HStack,
  IconButton,
  Spacer,
  Text,
} from "@chakra-ui/react";
import {
  AnalyticsIcon,
  BookmarksIcon,
  GrokIcon,
  LikeIcon,
  ReplyIcon,
  RepostIcon,
  ShareIcon,
  ThreeDotsIcon,
} from "../../../../../lib/components/icons";

import { Tooltip } from "@/lib/components/ui/tooltip";

interface TimelinePostCardProps {
  timelineItem: TimelineItem;
}

export const TimelinePostCard: React.FC<TimelinePostCardProps> = ({
  timelineItem,
}) => {
  return (
    <Box
      key={timelineItem.id}
      p="1"
      borderBottomWidth="1px"
      maxW="840px"
      borderColor="gray.700"
    >
      {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/808
    - Implementing the UI to display reposts and quote reposts. */}
      <Flex align="flex-start" gap="5">
        <Avatar.Root size="xl" mr="2">
          <Avatar.Fallback name={timelineItem.author_id} />
        </Avatar.Root>

        <Box flex="1">
          <Flex align="center">
            <HStack gap="2" mt="-3">
              {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/807
              - Get name and username from id. */}
              <Text fontWeight="bold">name</Text>
              <Text color="gray.500">@username</Text>
              <Text color="gray.500">·</Text>
              {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/806
              - Add time ago calculation. */}
              <Text color="gray.500">0h</Text>
            </HStack>
            <Spacer />

            <HStack mt="-6" gap="-2" mr="-1">
              <Tooltip
                content="Explain this post"
                positioning={{ placement: "bottom" }}
              >
                <IconButton
                  mt="5px"
                  bg="transparent"
                  borderRadius="full"
                  aria-label="arrow"
                  color={useColorModeValue("black", "gray.500")}
                  _hover={{ bg: "blue.500_10", color: "blue.400" }}
                >
                  <GrokIcon />
                </IconButton>
              </Tooltip>

              <Tooltip content="More" positioning={{ placement: "bottom" }}>
                <IconButton
                  mt="5px"
                  ml="-2"
                  bg="transparent"
                  borderRadius="full"
                  aria-label="More options"
                  color={useColorModeValue("black", "gray.500")}
                  _hover={{ bg: "blue.500_10", color: "blue.400" }}
                >
                  <ThreeDotsIcon />
                </IconButton>
              </Tooltip>
            </HStack>
          </Flex>

          {(() => {
            switch (timelineItem.type) {
              case "post":
              case "quoteRepost":
                return (
                  <Text mt="1" whiteSpace="pre-wrap">
                    {timelineItem.text}
                  </Text>
                );
              case "repost":
                return null;
              default:
                return null;
            }
          })()}

          <Flex
            mt="3"
            px="20"
            width="100%"
            justifyContent="space-between"
            alignItems="center"
            color="gray.500"
          >
            <HStack gap="120px" ml="-12" mr="120">
              <Tooltip content="Reply" positioning={{ placement: "bottom" }}>
                <IconButton
                  mt="5px"
                  bg="transparent"
                  borderRadius="full"
                  aria-label="Reply"
                  color={useColorModeValue("black", "gray.500")}
                  _hover={{ bg: "blue.500_10", color: "blue.400" }}
                  size="sm"
                  variant="ghost"
                >
                  <ReplyIcon boxSize="20px" />
                </IconButton>
              </Tooltip>

              <Tooltip content="Repost" positioning={{ placement: "bottom" }}>
                <IconButton
                  mt="5px"
                  bg="transparent"
                  borderRadius="full"
                  aria-label="Repost"
                  color={useColorModeValue("black", "gray.500")}
                  _hover={{ bg: "blue.500_10", color: "green.400" }}
                  size="sm"
                  variant="ghost"
                >
                  <RepostIcon boxSize="20px" />
                </IconButton>
              </Tooltip>

              <Tooltip content="Like" positioning={{ placement: "bottom" }}>
                <IconButton
                  mt="5px"
                  bg="transparent"
                  borderRadius="full"
                  aria-label="Like"
                  color={useColorModeValue("black", "gray.500")}
                  _hover={{ bg: "blue.500_10", color: "pink.400" }}
                  size="sm"
                  variant="ghost"
                >
                  <LikeIcon boxSize="20px" />
                </IconButton>
              </Tooltip>

              <Tooltip content="View" positioning={{ placement: "bottom" }}>
                <IconButton
                  mt="5px"
                  bg="transparent"
                  borderRadius="full"
                  aria-label="Analytics"
                  color={useColorModeValue("black", "gray.500")}
                  _hover={{ bg: "blue.500_10", color: "blue.400" }}
                  size="sm"
                  variant="ghost"
                >
                  <AnalyticsIcon boxSize="20px" />
                </IconButton>
              </Tooltip>
            </HStack>

            <HStack gap="-1" mr="-20">
              <Tooltip content="Bookmark" positioning={{ placement: "bottom" }}>
                <IconButton
                  mt="5px"
                  bg="transparent"
                  borderRadius="full"
                  color={useColorModeValue("black", "gray.500")}
                  _hover={{ bg: "blue.500_10", color: "blue.400" }}
                >
                  <BookmarksIcon />
                </IconButton>
              </Tooltip>

              <Tooltip content="Share" positioning={{ placement: "bottom" }}>
                <IconButton
                  mt="5px"
                  ml="-2"
                  bg="transparent"
                  borderRadius="full"
                  color={useColorModeValue("black", "gray.500")}
                  _hover={{ bg: "blue.500_10", color: "blue.400" }}
                >
                  <ShareIcon />
                </IconButton>
              </Tooltip>
            </HStack>
          </Flex>
        </Box>
      </Flex>
    </Box>
  );
};
