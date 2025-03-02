CREATE TABLE IF NOT EXISTS blocks (
    "source_user_id" UUID NOT NULL,
    "target_user_id" UUID NOT NULL,
    PRIMARY KEY (source_user_id, target_user_id),
    FOREIGN KEY (source_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)
);