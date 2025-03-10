CREATE TABLE IF NOT EXISTS timelineitems (
    "id" UUID DEFAULT gen_random_uuid () PRIMARY KEY,
    "type" VARCHAR(11) NOT NULL CHECK ("type" IN ('post', 'repost', 'quoteRepost')),
    "author_id" UUID NOT NULL,
    "parent_post_id" UUID,
    "text" VARCHAR(140) NOT NULL,
    "created_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_parent FOREIGN KEY ("parent_post_id") REFERENCES timelineitems("id") ON DELETE SET NULL,
    CONSTRAINT fk_author FOREIGN KEY ("author_id") REFERENCES users("id") ON DELETE CASCADE
);
