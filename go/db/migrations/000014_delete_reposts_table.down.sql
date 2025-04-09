CREATE TABLE IF NOT EXISTS reposts (
    "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    "parent_post_id" UUID,
    "user_id" UUID NOT NULL,
    "parent_repost_id" UUID,
    "is_quote" BOOLEAN NOT NULL DEFAULT false,
    "text" VARCHAR(140) NOT NULL,
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("parent_post_id") REFERENCES posts("id"),
    FOREIGN KEY ("user_id") REFERENCES users("id"),
    FOREIGN KEY ("parent_repost_id") REFERENCES reposts("id")
);
