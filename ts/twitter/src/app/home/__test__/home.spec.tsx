import { SessionProvider } from "@/lib/components/session-context";
import type { Post } from "@/lib/models/post";
import { VStack } from "@chakra-ui/react";
import { render, waitFor } from "@testing-library/react";
import { Home } from "../_components/home";
import { TimelinePostCard } from "../_components/timeline/timeline-post-card";

const mockPosts: Post[] = [
  {
    id: "123",
    user_id: "789",
    text: "test text",
    created_at: "2024-01-01",
  },
  {
    id: "456",
    user_id: "789",
    text: "test text2",
    created_at: "2024-01-01",
  },
];

vi.mock("../_components/timeline/timeline-feed", () => ({
  TimelineFeed: () => {
    return (
      <VStack spacing={4} align="stretch">
        {mockPosts.map((post) => (
          <TimelinePostCard key={post.id} post={post} />
        ))}
      </VStack>
    );
  },
}));

vi.mock("next/navigation", () => ({
  useRouter() {
    return {
      push: vi.fn(),
    };
  },
}));

describe("Home Tests", () => {
  // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/522
  // - Fix test descriptions in home.spec.tsx and post-modal.tsx.
  test("Rendering Home should succeed", () => {
    waitFor(() => {
      render(<Home />, { wrapper: SessionProvider });
    });
  });
});
