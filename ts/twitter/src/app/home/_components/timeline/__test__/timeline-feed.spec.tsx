import { render, screen, act } from "@testing-library/react";
import { TimelineFeed } from "../timeline-feed";
import { mockPosts } from "../__mocks__/post-data";
import { ERROR_MESSAGES } from "@/lib/constants/error-messages";
import { createTimelineFeedService } from "../timeline-feed-service";
import { FakeTimelineFeedService } from "../__fake__/fake-timeline-feed-service";

describe("TimelineFeed", () => {
  let service: FakeTimelineFeedService;

  beforeEach(() => {
    service = createTimelineFeedService() as FakeTimelineFeedService;
  });

  it("should display initial posts when timeline is accessed", async () => {
    render(<TimelineFeed />);

    await act(async () => {
      service.simulateMessage(mockPosts[0]);
    });

    expect(screen.getByText(mockPosts[0].posts[0].user_id)).toBeInTheDocument();
    expect(screen.getByText(mockPosts[0].posts[0].text)).toBeInTheDocument();
  });

  it("should add new post when post created event is received", async () => {
    render(<TimelineFeed />);

    await act(async () => {
      service.simulateMessage(mockPosts[1]);
    });

    expect(screen.getByText(mockPosts[1].posts[0].user_id)).toBeInTheDocument();
    expect(screen.getByText(mockPosts[1].posts[0].text)).toBeInTheDocument();
  });

  it("should display empty state message when no posts exist", () => {
    render(<TimelineFeed />);

    service.simulateMessage({
      event_type: "TimelineAccessed",
      posts: [],
    });

    expect(screen.getByText("Post not found.")).toBeInTheDocument();
  });

  it("should display server error when connection fails", async () => {
    render(<TimelineFeed />);

    await act(async () => {
      service.simulateError(ERROR_MESSAGES.SERVER_ERROR);
    });

    expect(screen.getByText(ERROR_MESSAGES.SERVER_ERROR)).toBeInTheDocument();
  });

  it("should display error message when receiving invalid data", async () => {
    render(<TimelineFeed />);

    await act(async () => {
      service.simulateError(ERROR_MESSAGES.INVALID_DATA);
    });

    expect(screen.getByText(ERROR_MESSAGES.INVALID_DATA)).toBeInTheDocument();
  });
});
