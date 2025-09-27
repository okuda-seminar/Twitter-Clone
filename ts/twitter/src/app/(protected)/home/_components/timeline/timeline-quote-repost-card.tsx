import type { Post, QuoteRepost } from "@/lib/models/post";
import { Avatar, Box, HStack, Text } from "@chakra-ui/react";
import { TimelineItemFrame } from "./timeline-item-frame";

interface TimelineQuoteRepostCardProps {
  quoteRepost: QuoteRepost;
}

export const TimelineQuoteRepostCard: React.FC<
  TimelineQuoteRepostCardProps
> = ({ quoteRepost }) => {
  // Dummy data
  const post: Post = {
    type: "post",
    id: "123",
    author_id: "test",
    text: "quoted post",
    created_at: "2024-01-01T00:00:00Z",
  };

  return (
    <Box p="4" borderBottomWidth="1px">
      <TimelineItemFrame timelineItem={quoteRepost}>
        <Text whiteSpace="pre-wrap">{quoteRepost.text}</Text>
        <QuotedTimelineItemCard quotedTimelineItem={post} />
      </TimelineItemFrame>
    </Box>
  );
};

interface QuotedTimelineItemCard {
  quotedTimelineItem: Post | QuoteRepost;
}

const QuotedTimelineItemCard: React.FC<QuotedTimelineItemCard> = ({
  quotedTimelineItem,
}) => {
  return (
    <Box
      borderWidth="1px"
      borderColor="gray.300"
      borderRadius="2xl"
      mt="3"
      p="3"
    >
      <HStack gap="2">
        <Avatar.Root size="2xs">
          <Avatar.Fallback name={quotedTimelineItem.author_id} />
        </Avatar.Root>
        <Text fontWeight="bold">name</Text>
        <Text color="gray.500">@username</Text>
        <Text color="gray.500">·</Text>
        <Text color="gray.500">0h</Text>
      </HStack>
      <Text whiteSpace="pre-wrap">{quotedTimelineItem.text}</Text>
    </Box>
  );
};
