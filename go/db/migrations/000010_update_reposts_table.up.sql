ALTER TABLE reposts RENAME COLUMN "post_id" TO "parent_post_id";

ALTER TABLE reposts
    DROP CONSTRAINT IF EXISTS reposts_pkey,
    ALTER COLUMN "parent_post_id" DROP NOT NULL,
    ADD COLUMN "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    ADD COLUMN "parent_repost_id" UUID,
    ADD COLUMN "is_quote" BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN "text" VARCHAR(140) NOT NULL,
    ADD COLUMN "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ADD FOREIGN KEY (parent_repost_id) REFERENCES reposts(id);
