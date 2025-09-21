"use client";
import { Box, Text, VStack } from "@chakra-ui/react";
import { TrendingHashtagsList } from "./trending-hashtags-list";
import { TrendingNewsList } from "./trending-news-list";
import { UserRecommendationList } from "./user-recommendation-list";

import { dummyHashtags } from "@/lib/components/right-column/dummy/hashtags";
import { dummyNews } from "@/lib/components/right-column/dummy/news";
import { dummyUsers } from "@/lib/components/right-column/dummy/users";

export default function ForYou() {
  return (
    <VStack align="stretch" px="4" gap="8">
      <Text fontSize="xl" fontWeight="bold" mb="2" pl="3">
        Today's News
      </Text>
      <Box divideY="1px">
        <TrendingNewsList news={dummyNews} />
        <TrendingHashtagsList hashtags={dummyHashtags} />
      </Box>

      <Box>
        <Text fontSize="xl" fontWeight="bold" mb="2" pl="3">
          Who to follow
        </Text>
        <UserRecommendationList users={dummyUsers} />
      </Box>
    </VStack>
  );
}
