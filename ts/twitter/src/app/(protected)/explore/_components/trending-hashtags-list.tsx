import { Tooltip } from "@/lib/components/ui/tooltip";
import { Box, Flex, IconButton, Text, VStack } from "@chakra-ui/react";
import type React from "react";
import { ThreeDotsIcon } from "../../../../lib/components/icons";
import type { Hashtags } from "../../../../lib/components/right-column/dummy/hashtags";

interface TrendingHashtagsListProps {
  hashtags: Hashtags[];
}

export const TrendingHashtagsList: React.FC<TrendingHashtagsListProps> = ({
  hashtags,
}) => {
  const formatPostCount = (count: number): string => {
    if (count >= 1000) {
      return `${Math.floor(count / 1000)}K posts`;
    }
    return `${count.toLocaleString()} posts`;
  };

  return (
    <VStack align="stretch" width="full">
      {hashtags.map((hashtag) => (
        <Box key={hashtag.id} px="4" py="3">
          <Flex justify="space-between" align="flex-start">
            <VStack align="flex-start" gap="1" flex="1">
              <Text fontSize="sm" color="gray.500">
                {hashtag.category} • Trending
              </Text>

              <Text fontWeight="bold" fontSize="md">
                {hashtag.text}
              </Text>

              <Text fontSize="sm" color="gray.500">
                {formatPostCount(hashtag.postCount)}
              </Text>
            </VStack>

            <Tooltip content="more">
              <IconButton
                variant="ghost"
                size="sm"
                borderRadius="full"
                aria-label="More options"
              >
                <ThreeDotsIcon />
              </IconButton>
            </Tooltip>
          </Flex>
        </Box>
      ))}
    </VStack>
  );
};
