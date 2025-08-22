"use client";

import { useColorModeValue } from "@/lib/components/ui/color-mode";
import { Tooltip } from "@/lib/components/ui/tooltip";
import type { TimelineItem } from "@/lib/models/post";
import {
  Avatar,
  Box,
  Flex,
  HStack,
  IconButton,
  Menu,
  Portal,
  Text,
} from "@chakra-ui/react";
import {
  AnalyticsIcon,
  BookmarksIcon,
  DeleteIcon,
  EmbeddingIcon,
  GrokIcon,
  HighlightIcon,
  LikeIcon,
  ListIcon,
  PinIcon,
  ReplyIcon,
  RepostIcon,
  RequestIcon,
  ShareIcon,
  ThreeDotsIcon,
} from "../../../../../lib/components/icons";

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
            <Box flex="1" />

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
                <Menu.Root positioning={{ placement: "left-start" }}>
                  <Menu.Trigger asChild>
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
                  </Menu.Trigger>

                  <Portal>
                    <Menu.Positioner
                      backgroundColor={useColorModeValue("white", "black")}
                    >
                      <Menu.Content
                        transform="translate(18%, 2%)"
                        backgroundColor={useColorModeValue("white", "black")}
                        widows="100%"
                        borderRadius="md"
                      >
                        <Menu.Item value="delete" color="red.400">
                          <Flex align="center" p="8px" w="100%">
                            <DeleteIcon
                              boxSize="20px"
                              style={{ marginRight: "8px" }}
                            />
                            <Text>Delete</Text>
                          </Flex>
                        </Menu.Item>
                        <Menu.Item value="pin">
                          <Flex align="center" p="8px" w="100%">
                            <PinIcon
                              boxSize="20px"
                              style={{ marginRight: "8px" }}
                            />
                            <Text>Pin to your profile</Text>
                          </Flex>
                        </Menu.Item>
                        <Menu.Item value="highlight">
                          <Flex align="center" p="8px" w="100%">
                            <HighlightIcon
                              boxSize="20px"
                              style={{ marginRight: "8px" }}
                            />
                            <Text>Highlight on your profile</Text>
                          </Flex>
                        </Menu.Item>
                        <Menu.Item value="list">
                          <Flex align="center" p="8px" w="100%">
                            <ListIcon
                              boxSize="20px"
                              style={{ marginRight: "8px" }}
                            />
                            <Text>Add/remove from Lists</Text>
                          </Flex>
                        </Menu.Item>
                        <Menu.Item value="reply">
                          <Flex align="center" p="8px" w="100%">
                            <ReplyIcon
                              boxSize="20px"
                              style={{ marginRight: "8px" }}
                            />
                            <Text>Change who can reply</Text>
                          </Flex>
                        </Menu.Item>
                        <Menu.Item value="engagements">
                          <Flex align="center" p="8px" w="100%">
                            <AnalyticsIcon
                              boxSize="20px"
                              style={{ marginRight: "8px" }}
                            />
                            <Text>View post engagements</Text>
                          </Flex>
                        </Menu.Item>
                        <Menu.Item value="embedding">
                          <Flex align="center" p="8px" w="100%">
                            <EmbeddingIcon
                              boxSize="20px"
                              style={{ marginRight: "8px" }}
                            />
                            <Text>Embeded post</Text>
                          </Flex>
                        </Menu.Item>
                        <Menu.Item value="analytics">
                          <Flex align="center" p="8px" w="100%">
                            <AnalyticsIcon
                              boxSize="20px"
                              style={{ marginRight: "8px" }}
                            />
                            <Text>View post analytics</Text>
                          </Flex>
                        </Menu.Item>
                        <Menu.Item value="request">
                          <Flex align="center" p="8px" w="100%">
                            <RequestIcon
                              boxSize="20px"
                              style={{ marginRight: "8px" }}
                            />
                            <Text>Request community note</Text>
                          </Flex>
                        </Menu.Item>
                      </Menu.Content>
                    </Menu.Positioner>
                  </Portal>
                </Menu.Root>
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

          <Flex mt="3" width="100%" alignItems="center" color="gray.500">
            <Flex flex="1" justifyContent="flex-start">
              <Box flex="1 1 25%">
                <Tooltip content="Reply" positioning={{ placement: "bottom" }}>
                  <IconButton
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
              </Box>

              <Box flex="1 1 25%">
                <Tooltip content="Repost" positioning={{ placement: "bottom" }}>
                  <IconButton
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
              </Box>

              <Box flex="1 1 25%">
                <Tooltip content="Like" positioning={{ placement: "bottom" }}>
                  <IconButton
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
              </Box>

              <Box flex="1 1 25%">
                <Tooltip content="View" positioning={{ placement: "bottom" }}>
                  <IconButton
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
              </Box>
            </Flex>

            <Flex flex="0 0 auto" justifyContent="flex-end" gap="-20" mr="-2">
              <Tooltip content="Bookmark" positioning={{ placement: "bottom" }}>
                <IconButton
                  bg="transparent"
                  borderRadius="full"
                  aria-label="Bookmark"
                  color={useColorModeValue("black", "gray.500")}
                  _hover={{ bg: "blue.500_10", color: "blue.400" }}
                >
                  <BookmarksIcon />
                </IconButton>
              </Tooltip>

              <Tooltip content="Share" positioning={{ placement: "bottom" }}>
                <IconButton
                  bg="transparent"
                  borderRadius="full"
                  aria-label="Share"
                  color={useColorModeValue("black", "gray.500")}
                  _hover={{ bg: "blue.500_10", color: "blue.400" }}
                >
                  <ShareIcon />
                </IconButton>
              </Tooltip>
            </Flex>
          </Flex>
        </Box>
      </Flex>
    </Box>
  );
};
