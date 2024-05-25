CREATE TABLE IF NOT EXISTS mutes (
    muted_user_id UUID NOT NULL,
    muting_user_id UUID NOT NULL,
    PRIMARY KEY (muted_user_id, muting_user_id),
    FOREIGN KEY (muted_user_id) REFERENCES users(id),
    FOREIGN KEY (muting_user_id) REFERENCES users(id)
);
