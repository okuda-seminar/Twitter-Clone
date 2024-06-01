CREATE TABLE IF NOT EXISTS blocks (
    blocked_user_id UUID NOT NULL,
    blocking_user_id UUID NOT NULL,
    PRIMARY KEY (blocked_user_id, blocking_user_id),
    FOREIGN KEY (blocked_user_id) REFERENCES users(id),
    FOREIGN KEY (blocking_user_id) REFERENCES users(id)
);
