import express, { json } from "express";
import cors from "cors";
const app = express();
const port = 3002;

app.use(cors());
app.use(json());

let posts = [];

// This is a temporary server created as a stopgap measure.
// It will be used temporarily while waiting for the actual server to be implemented by the backend team.
// The plan is to delete this server in the future once it's no longer needed.

// TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/437
// - Cleanup temporary server files in api/ directory after backend implementation.

app.post("/api/posts", (req, res) => {
  const newPost = {
    id: Date.now().toString(),
    ...req.body,
  };
  posts[newPost.id] = newPost;
  res.status(201).json(newPost);
});

app.get("/api/posts", (req, res) => {
  res.json(Object.values(posts));
});

app.get("/api/posts/:id", (req, res) => {
  const post = posts[req.params.id];
  if (post) {
    res.json(post);
  } else {
    res.status(404).json({ message: "Post not found" });
  }
});

app.listen(port, () => {
  console.log(`API server listening at http://localhost:${port}`);
});
