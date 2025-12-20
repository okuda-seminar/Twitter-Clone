import { createRepost } from "@/lib/actions/create-repost";
import { useAuth } from "@/lib/components/auth-context";
import { useComposeModal } from "@/lib/components/compose-modal-context";
import {
  AnalyticsIcon,
  BookmarksIcon,
  GrokIcon,
  LikeIcon,
  ReplyIcon,
  RepostIcon,
  ShareIcon,
} from "@/lib/components/icons";
import { Tooltip } from "@/lib/components/ui/tooltip";
import type { Post, QuoteRepost } from "@/lib/models/post";
import { Avatar, Box, Flex, HStack, IconButton, Text } from "@chakra-ui/react";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { RepostQuoteMenu } from "./repost-quote-menu";
import { TimelinePostCardPopupMenu } from "./timeline-post-card-popup-menu";

interface TimelineItemFrameProps extends React.PropsWithChildren {
  timelineItem: Post | QuoteRepost;
}

export const TimelineItemFrame: React.FC<TimelineItemFrameProps> = ({
  timelineItem,
  children,
}) => {
  const router = useRouter();
  const { user } = useAuth();
  const { setQuotedPost } = useComposeModal();

  const handleRepostClick = async () => {
    if (!user?.id) return;
    const result = await createRepost(user.id, {
      post_id: timelineItem.id,
    });
    if (result.ok) {
      console.log("Repost successful");
    } else {
      console.error("Repost failed:", result.error);
    }
  };

  const handleQuoteClick = () => {
    setQuotedPost(timelineItem);
    router.push("/compose/post");
  };

  return (
    <Flex gap="2">
      <Avatar.Root size="lg">
        <Avatar.Fallback name={timelineItem.authorId} />
      </Avatar.Root>
      <Box flex="1">
        <TimelineItemHeader />
        {children}
        <TimelineItemFooter
          handleRepostClick={handleRepostClick}
          handleQuoteClick={handleQuoteClick}
        />
      </Box>
    </Flex>
  );
};

const TimelineItemHeader = () => {
  return (
    <Flex justifyContent="space-between" height="5">
      <HStack gap="2">
        {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/807
        - Get name and username from id. */}
        <Text fontWeight="bold">name</Text>
        <Text color="gray.500">@username</Text>
        <Text color="gray.500">·</Text>
        {/* TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/806
        - Add time ago calculation. */}
        <Text color="gray.500">0h</Text>
      </HStack>
      <HStack>
        <Tooltip
          content="Explain this post"
          positioning={{ placement: "bottom" }}
        >
          <IconButton
            minW={0}
            bg="transparent"
            borderRadius="full"
            aria-label="grok"
            color="gray.500"
            _hover={{ color: "blue.400" }}
          >
            <GrokIcon />
          </IconButton>
        </Tooltip>

        <TimelinePostCardPopupMenu />
      </HStack>
    </Flex>
  );
};

const TimelineItemFooter = ({
  handleRepostClick,
  handleQuoteClick,
}: { handleRepostClick: () => void; handleQuoteClick: () => void }) => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  return (
    <Flex justifyContent="space-between" alignItems="center" color="gray.500">
      <Tooltip content="Reply" positioning={{ placement: "bottom" }}>
        <IconButton
          minW={0}
          bg="transparent"
          borderRadius="full"
          aria-label="Reply"
          color="gray.500"
          _hover={{ color: "blue.400" }}
          size="sm"
          variant="ghost"
        >
          <ReplyIcon boxSize="20px" />
        </IconButton>
      </Tooltip>

      <Tooltip
        content="Repost"
        positioning={{ placement: "bottom" }}
        disabled={isMenuOpen}
      >
        <Box display="inline-block">
          <RepostQuoteMenu
            onRepostClick={handleRepostClick}
            onQuoteClick={handleQuoteClick}
            open={isMenuOpen}
            onOpenChange={(details) => setIsMenuOpen(details.open)}
          >
            <IconButton
              minW={0}
              bg="transparent"
              borderRadius="full"
              aria-label="Repost"
              color="gray.500"
              _hover={{ color: "green.400" }}
              size="sm"
              variant="ghost"
            >
              <RepostIcon boxSize="20px" />
            </IconButton>
          </RepostQuoteMenu>
        </Box>
      </Tooltip>

      <Tooltip content="Like" positioning={{ placement: "bottom" }}>
        <IconButton
          minW={0}
          bg="transparent"
          borderRadius="full"
          aria-label="Like"
          color="gray.500"
          _hover={{ color: "pink.400" }}
          size="sm"
          variant="ghost"
        >
          <LikeIcon boxSize="20px" />
        </IconButton>
      </Tooltip>

      <Tooltip content="View" positioning={{ placement: "bottom" }}>
        <IconButton
          minW={0}
          bg="transparent"
          borderRadius="full"
          aria-label="Analytics"
          color="gray.500"
          _hover={{ color: "blue.400" }}
          size="sm"
          variant="ghost"
        >
          <AnalyticsIcon boxSize="20px" />
        </IconButton>
      </Tooltip>

      <HStack gap="2">
        <Tooltip content="Bookmark" positioning={{ placement: "bottom" }}>
          <IconButton
            minW={0}
            bg="transparent"
            borderRadius="full"
            aria-label="Bookmark"
            color="gray.500"
            _hover={{ color: "blue.400" }}
          >
            <BookmarksIcon />
          </IconButton>
        </Tooltip>

        <Tooltip content="Share" positioning={{ placement: "bottom" }}>
          <IconButton
            minW={0}
            bg="transparent"
            borderRadius="full"
            aria-label="Share"
            color="gray.500"
            _hover={{ color: "blue.400" }}
          >
            <ShareIcon />
          </IconButton>
        </Tooltip>
      </HStack>
    </Flex>
  );
};
