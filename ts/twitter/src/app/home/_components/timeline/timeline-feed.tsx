import { VStack, Text } from "@chakra-ui/react";
import { getCollectionOfPostsBySpecificUserAndUsersTheyFollow } from "@/lib/actions/get-collection-of-posts-by-specific-user-and-users-they-follow";
import { TimelinePostCard } from "./timeline-post-card";

export const TimelineFeed = async () => {
  const posts = await getCollectionOfPostsBySpecificUserAndUsersTheyFollow({
    user_id: `${process.env.NEXT_PUBLIC_USER_ID}`,
  });

  if (!posts || posts.length === 0) {
    return <Text>No posts found.</Text>;
  }

  return (
    <VStack spacing={4} align="stretch">
      {posts.map((post) => (
        <TimelinePostCard key={post.id} post={post} />
      ))}
    </VStack>
  );
};
