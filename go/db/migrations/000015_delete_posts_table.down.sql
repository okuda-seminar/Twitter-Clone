CREATE TABLE IF NOT EXISTS posts (
    "id" UUID DEFAULT gen_random_uuid () PRIMARY KEY,
    "user_id" UUID NOT NULL,
    "text" VARCHAR(140) NOT NULL,
    "created_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user FOREIGN KEY ("user_id") REFERENCES users("id") ON DELETE CASCADE;
);
