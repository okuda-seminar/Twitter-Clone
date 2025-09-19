import type { TimelineItem } from "@/lib/models/post";
import { TimelinePostCard } from "./timeline-post-card";
import { TimelineRepostCard } from "./timeline-repost-card";

interface TimelineItemCardProps {
  timelineItem: TimelineItem;
}

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/808
// - Implementing the UI to display reposts and quote reposts.
export const TimelineItemCard: React.FC<TimelineItemCardProps> = ({
  timelineItem,
}) => {
  switch (timelineItem.type) {
    case "post":
      return <TimelinePostCard post={timelineItem} />;
    case "repost":
      return <TimelineRepostCard repost={timelineItem} />;
    default:
      return null;
  }
};
