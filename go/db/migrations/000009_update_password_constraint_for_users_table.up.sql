ALTER TABLE users
ADD CONSTRAINT password_not_empty CHECK (password <> '');