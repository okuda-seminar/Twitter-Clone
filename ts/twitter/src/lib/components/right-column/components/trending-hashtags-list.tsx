import { Box, Button, Flex, IconButton, Text, VStack } from "@chakra-ui/react";
import type React from "react";
import { ThreeDotsIcon } from "../../icons";
import { useColorModeValue } from "../../ui/color-mode";
import { Tooltip } from "../../ui/tooltip";
import type { Hashtags } from "../dummy/hashtags";

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
    <VStack
      border="0.5px solid"
      borderColor={useColorModeValue("gray.200", "gray.700")}
      borderRadius="xl"
      align="stretch"
      width="full"
    >
      <Text textAlign="left" ml="4" mt="3" fontWeight="bold" fontSize="xl">
        What's happening
      </Text>

      {hashtags.map((hashtag, index) => (
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
              <IconButton variant="ghost" size="sm" borderRadius="full">
                <ThreeDotsIcon />
              </IconButton>
            </Tooltip>
          </Flex>
        </Box>
      ))}
      <Button
        textAlign="left"
        justifyContent="flex-start"
        color="blue.primary"
        bg="transparent"
        mb="1"
      >
        Show more
      </Button>
    </VStack>
  );
};
