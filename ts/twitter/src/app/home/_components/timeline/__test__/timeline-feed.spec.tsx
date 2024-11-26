import { render, screen, act } from "@testing-library/react";
import { TimelineFeed } from "../timeline-feed";
import { mockPosts } from "../__mocks__/post-data";
import { ERROR_MESSAGES } from "@/lib/constants/error-messages";

describe("Timeline Feed Tests", () => {
  let mockEventSource: any;

  beforeEach(() => {
    mockEventSource = {
      close: jest.fn(),
      addEventListener: jest.fn(),
      removeEventListener: jest.fn(),
    };

    // @ts-ignore
    global.EventSource = jest.fn(() => mockEventSource);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  test("Displays posts in timeline when SSE message is received", () => {
    render(<TimelineFeed />);

    act(() => {
      const messageHandler = mockEventSource.onmessage;
      messageHandler({ data: JSON.stringify(mockPosts) });
    });

    expect(screen.getByText(mockPosts[0].user_id)).toBeInTheDocument();
    expect(screen.getByText(mockPosts[0].text)).toBeInTheDocument();
  });

  test("Displays 'post not found.' when there are no posts", () => {
    render(<TimelineFeed />);

    act(() => {
      const messageHandler = mockEventSource.onmessage;
      messageHandler({ data: null });
    });

    expect(screen.getByText("Post not found.")).toBeInTheDocument();
  });

  test("Displays error message when SSE connection fails due to invalid URL", () => {
    const buildEndpoint = process.env;
    process.env = {
      ...buildEndpoint,
      NEXT_PUBLIC_LOCAL_API_BASE_URL: "invalid-url",
      NEXT_PUBLIC_USER_ID: "test-user",
    };

    render(<TimelineFeed />);

    act(() => {
      const errorHandler = mockEventSource.onerror;
      errorHandler();
    });

    expect(screen.getByText(ERROR_MESSAGES.SERVER_ERROR)).toBeInTheDocument();

    process.env = buildEndpoint;
  });

  test("Displays error message when SSE message contains invalid JSON data", () => {
    render(<TimelineFeed />);

    act(() => {
      const messageHandler = mockEventSource.onmessage;
      messageHandler({ data: "invalid json data{]" });
    });

    expect(screen.getByText(ERROR_MESSAGES.INVALID_DATA)).toBeInTheDocument();
  });
});
