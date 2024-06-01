CREATE TABLE IF NOT EXISTS retweets (
    tweet_id UUID NOT NULL,
    user_id UUID NOT NULL,
    PRIMARY KEY (tweet_id, user_id),
    FOREIGN KEY (tweet_id) REFERENCES tweets(id)
);
