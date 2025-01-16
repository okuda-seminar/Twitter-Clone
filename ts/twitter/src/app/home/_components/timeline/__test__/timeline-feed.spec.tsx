import { render, screen, act } from "@testing-library/react";
import { TimelineFeed } from "../timeline-feed";
import { mockPosts } from "../__mocks__/post-data";
import { ERROR_MESSAGES } from "@/lib/constants/error-messages";

describe("Timeline Feed Tests", () => {
  let mockEventSource: any;

  beforeEach(() => {
    mockEventSource = {
      close: jest.fn(),
    };

    // @ts-ignore
    global.EventSource = jest.fn(() => mockEventSource);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  test("Displays initial posts in timeline when TimelineAccessed event is received", () => {
    render(<TimelineFeed />);

    act(() => {
      const messageHandler = mockEventSource.onmessage;
      messageHandler({ data: JSON.stringify(mockPosts[0]) });
    });

    expect(screen.getByText(mockPosts[0].posts[0].user_id)).toBeInTheDocument();
    expect(screen.getByText(mockPosts[0].posts[0].text)).toBeInTheDocument();
  });

  test("Adds new post to timeline when PostCreated event is received", () => {
    render(<TimelineFeed />);

    act(() => {
      const messageHandler = mockEventSource.onmessage;
      messageHandler({ data: JSON.stringify(mockPosts[1]) });
    });

    expect(screen.getByText(mockPosts[1].posts[0].user_id)).toBeInTheDocument();
    expect(screen.getByText(mockPosts[1].posts[0].text)).toBeInTheDocument();
  });

  test("Displays 'post not found.' when there are no posts", () => {
    render(<TimelineFeed />);

    expect(screen.getByText("Post not found.")).toBeInTheDocument();
  });

  test("Displays error message when SSE connection fails due to invalid URL", () => {
    render(<TimelineFeed />);

    act(() => {
      const errorHandler = mockEventSource.onerror;
      errorHandler();
    });

    expect(screen.getByText(ERROR_MESSAGES.SERVER_ERROR)).toBeInTheDocument();
  });

  test("Displays error message when SSE message contains invalid JSON data", () => {
    render(<TimelineFeed />);

    act(() => {
      const messageHandler = mockEventSource.onmessage;
      messageHandler({ data: "invalid json data{}" });
    });

    expect(screen.getByText(ERROR_MESSAGES.INVALID_DATA)).toBeInTheDocument();
  });
});
