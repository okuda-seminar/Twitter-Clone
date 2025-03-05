ALTER TABLE reposts RENAME COLUMN "parent_post_id" TO "post_id";

ALTER TABLE reposts
    ALTER COLUMN "post_id" SET NOT NULL,
    DROP COLUMN IF EXISTS "id",
    DROP COLUMN IF EXISTS "parent_repost_id",
    DROP COLUMN IF EXISTS "is_quote",
    DROP COLUMN IF EXISTS "text",
    DROP COLUMN IF EXISTS "created_at",
    ADD PRIMARY KEY (post_id, user_id);
