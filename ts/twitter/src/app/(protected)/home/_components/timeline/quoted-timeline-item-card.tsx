import type { Post, QuoteRepost } from "@/lib/models/post";
import { Avatar, Box, HStack, Text } from "@chakra-ui/react";

interface QuotedTimelineItemCardProps {
  quotedTimelineItem: Post | QuoteRepost;
}

export const QuotedTimelineItemCard: React.FC<QuotedTimelineItemCardProps> = ({
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
          <Avatar.Fallback name={quotedTimelineItem.authorId} />
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
