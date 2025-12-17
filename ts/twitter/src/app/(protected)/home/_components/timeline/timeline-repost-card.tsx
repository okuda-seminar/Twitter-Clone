import { RepostIcon } from "@/lib/components/icons";
import type { Post, Repost } from "@/lib/models/post";
import { Box, Flex, IconButton, Spinner, Text } from "@chakra-ui/react";
import { useEffect, useState } from "react";
import { TimelineItemFrame } from "./timeline-item-frame";

interface TimelineRepostCardProps {
  repost: Repost;
  parentPost?: Post;
}

export const TimelineRepostCard: React.FC<TimelineRepostCardProps> = ({
  repost,
  parentPost: parentPostProp,
}) => {
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
        const parentPostId = repost.parentPostId.UUID;
        if (!parentPostId) {
          throw new Error("Parent post ID not found");
        }

        const url = `${process.env.NEXT_PUBLIC_LOCAL_API_BASE_URL}/api/posts/${parentPostId}`;
        const res = await fetch(url);
        if (!res.ok) {
          console.error("API response not OK:", res.status, res.statusText);
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
  }, [repost, parentPostProp]);

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
        <Text color="red.500">Failed to load repost</Text>
      </Box>
    );
  }

  return (
    <Box p="4" borderBottomWidth="1px">
      <Flex gap="2" mb="2">
        <IconButton
          minW={0}
          ml="6"
          height="4"
          bg="transparent"
          borderRadius="full"
          aria-label="Repost"
          color="gray.500"
          _hover={{ color: "green.400" }}
          size="sm"
          variant="ghost"
        >
          <RepostIcon boxSize="4" />
        </IconButton>
        <Text
          fontWeight="bold"
          fontSize="sm"
          color="gray.500"
          lineHeight="16px"
        >
          name reposted
        </Text>
      </Flex>
      <TimelineItemFrame timelineItem={parentPost}>
        <Text whiteSpace="pre-wrap">{parentPost.text}</Text>
      </TimelineItemFrame>
    </Box>
  );
};
