export interface Post {
  type: "post";
  id: string;
  author_id: string;
  text: string;
  created_at: string;
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
  author_id: string;
  parent_post_id: string;
  text: string;
  created_at: string;
}

export type TimelineItem = Post | Repost | QuoteRepost;
