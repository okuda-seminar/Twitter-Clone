CREATE TABLE IF NOT EXISTS likes (
    "post_id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    PRIMARY KEY (post_id, user_id),
    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);