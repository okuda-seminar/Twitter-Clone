CREATE TABLE IF NOT EXISTS followships (
    followed_user_id UUID NOT NULL,
    following_user_id UUID NOT NULL,
    PRIMARY KEY (followed_user_id, following_user_id),
    FOREIGN KEY (followed_user_id) REFERENCES users(id),
    FOREIGN KEY (following_user_id) REFERENCES users(id)
);
