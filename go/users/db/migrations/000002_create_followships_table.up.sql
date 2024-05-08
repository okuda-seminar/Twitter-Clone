CREATE TABLE IF NOT EXISTS followships (
    follower_id UUID NOT NULL,
    followee_id UUID NOT NULL,
    PRIMARY KEY (follower_id, followee_id),
    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (followee_id) REFERENCES users(id)
);
