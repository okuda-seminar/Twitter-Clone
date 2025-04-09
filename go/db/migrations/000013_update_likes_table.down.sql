ALTER TABLE likes DROP CONSTRAINT IF EXISTS likes_post_id_fkey;

ALTER TABLE likes ADD CONSTRAINT likes_post_id_fkey FOREIGN KEY ("post_id") REFERENCES posts("id");
