import { Box, CloseButton, Flex, Text, VStack } from "@chakra-ui/react";
import type React from "react";
import { useColorModeValue } from "../../ui/color-mode";
import type { News } from "../dummy/news";

interface TrendingNewsListProps {
  news: News[];
}

export const TrendingNewsList: React.FC<TrendingNewsListProps> = ({ news }) => {
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
      px="2"
    >
      <Flex textAlign="left" justify="space-between">
        <Text ml="2" mt="3" fontWeight="bold" fontSize="xl">
          Today's News
        </Text>
        <CloseButton borderRadius="full" mt="2" />
      </Flex>

      {news.map((news) => (
        <Box key={news.id} px="2" py="2">
          <VStack align="flex-start" gap="1">
            <Text fontSize="sm" color="gray.500">
              {news.category} • Trending
            </Text>
            <Text fontWeight="bold" fontSize="md">
              {news.title}
            </Text>
            <Text fontSize="sm" color="gray.500">
              {formatPostCount(news.postCount)}
            </Text>
          </VStack>
        </Box>
      ))}
    </VStack>
  );
};
