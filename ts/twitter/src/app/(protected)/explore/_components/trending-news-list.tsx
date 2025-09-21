import { Box, Text, VStack } from "@chakra-ui/react";
import type React from "react";
import type { News } from "../../../../lib/components/right-column/dummy/news";

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
    <VStack align="stretch" width="full" px="2">
      {news.map((item) => (
        <Box key={item.id} px="2" py="2">
          <VStack align="flex-start" gap="1">
            <Text fontWeight="bold" fontSize="md">
              {item.title}
            </Text>
            <Text fontSize="sm" color="gray.500">
              {formatPostCount(item.postCount)}
            </Text>
          </VStack>
        </Box>
      ))}
    </VStack>
  );
};
