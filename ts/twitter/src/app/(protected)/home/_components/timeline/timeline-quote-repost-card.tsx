import type { Post, QuoteRepost } from "@/lib/models/post";
import { Box, Flex, Spinner, Text } from "@chakra-ui/react";
import { useEffect, useState } from "react";
import { QuotedTimelineItemCard } from "./quoted-timeline-item-card";
import { TimelineItemFrame } from "./timeline-item-frame";

interface TimelineQuoteRepostCardProps {
  quoteRepost: QuoteRepost;
  parentPost?: Post;
}

export const TimelineQuoteRepostCard: React.FC<
  TimelineQuoteRepostCardProps
> = ({ quoteRepost, parentPost: parentPostProp }) => {
  const [parentPost, setParentPost] = useState<Post | null>(
    parentPostProp || null,
  );
  const [loading, setLoading] = useState(!parentPostProp);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    // Skip fetch if parentPost prop is provided
    if (parentPostProp) {
      return;
    }

    const fetchParentPost = async () => {
      try {
        const parentPostId = quoteRepost.parentPostId.UUID;
        if (!parentPostId) {
          throw new Error("Parent post ID not found");
        }

        const url = `${process.env.NEXT_PUBLIC_LOCAL_API_BASE_URL}/api/posts/${parentPostId}`;
        const res = await fetch(url);
        if (!res.ok) {
          throw new Error("Failed to fetch parent post");
        }

        const data = await res.json();
        setParentPost(data);
      } catch (err) {
        setError(err instanceof Error ? err.message : "Unknown error");
      } finally {
        setLoading(false);
      }
    };

    fetchParentPost();
  }, [quoteRepost, parentPostProp]);

  if (loading) {
    return (
      <Box p="4" borderBottomWidth="1px">
        <Flex justify="center" align="center" minH="100px">
          <Spinner />
        </Flex>
      </Box>
    );
  }

  if (error || !parentPost) {
    return (
      <Box p="4" borderBottomWidth="1px">
        <Text color="red.500">Failed to load quote repost</Text>
      </Box>
    );
  }

  return (
    <Box p="4" borderBottomWidth="1px">
      <TimelineItemFrame timelineItem={quoteRepost}>
        <Text whiteSpace="pre-wrap">{quoteRepost.text}</Text>
        <QuotedTimelineItemCard quotedTimelineItem={parentPost} />
      </TimelineItemFrame>
    </Box>
  );
};
