export interface Post {
  type: "post";
  id: string;
  authorId: string;
  text: string;
  createdAt: string;
}

export interface Repost {
  type: "repost";
  id: string;
  authorId: string;
  parentPostId: { UUID: string; Valid: boolean };
  createdAt: string;
}

export interface QuoteRepost {
  type: "quoteRepost";
  id: string;
  authorId: string;
  parentPostId: { UUID: string; Valid: boolean };
  text: string;
  createdAt: string;
}

export interface OptimisticQuoteRepost extends QuoteRepost {
  isOptimistic?: boolean;
  tempId?: string;
}

export type TimelineItem = Post | Repost | QuoteRepost | OptimisticQuoteRepost;
