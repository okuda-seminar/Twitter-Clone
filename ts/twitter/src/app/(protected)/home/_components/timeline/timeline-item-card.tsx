import type { TimelineItem } from "@/lib/models/post";
import { memo } from "react";
import { TimelinePostCard } from "./timeline-post-card";
import { TimelineQuoteRepostCard } from "./timeline-quote-repost-card";
import { TimelineRepostCard } from "./timeline-repost-card";

interface TimelineItemCardProps {
  timelineItem: TimelineItem;
}

const TimelineItemCardComponent: React.FC<TimelineItemCardProps> = ({
  timelineItem,
}) => {
  switch (timelineItem.type) {
    case "post":
      return <TimelinePostCard post={timelineItem} />;
    case "repost":
      return <TimelineRepostCard repost={timelineItem} />;
    case "quoteRepost":
      return <TimelineQuoteRepostCard quoteRepost={timelineItem} />;
    default:
      return null;
  }
};

export const TimelineItemCard = memo(TimelineItemCardComponent);
