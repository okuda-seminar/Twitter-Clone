"use client";
import {
  Input,
  InputGroup,
  VStack,
  useBreakpointValue,
} from "@chakra-ui/react";
import type React from "react";
import { SearchIcon } from "../icons";
import { PremiumSubscriptionCard } from "./components/premium-subscription-card";
import { TrendingHashtagsList } from "./components/trending-hashtags-list";
import { TrendingNewsList } from "./components/trending-news-list";
import { UserRecommendationList } from "./components/user-recommendation-list";
import { dummyHashtags } from "./dummy/hashtags";
import { dummyNews } from "./dummy/news";
import { dummyUsers } from "./dummy/users";

export const RightColumn: React.FC = () => {
  return (
    <VStack
      gap="4"
      w="350px"
      mx="8"
      display={useBreakpointValue({ base: "none", lg: "flex" })}
    >
      <InputGroup startElement={<SearchIcon size="sm" />} mt="2">
        <Input placeholder="Search" borderRadius="full" />
      </InputGroup>
      <PremiumSubscriptionCard />
      <TrendingNewsList news={dummyNews} />
      <TrendingHashtagsList hashtags={dummyHashtags} />
      <UserRecommendationList users={dummyUsers} />
    </VStack>
  );
};
