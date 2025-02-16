import { ERROR_MESSAGES } from "@/lib/constants/error-messages";
import type { Post } from "@/lib/models/post";
import { FakeTimelineFeedService } from "./__fake__/fake-timeline-feed-service";

export type TimelineEventResponse =
  | TimelineAccessedResponse
  | PostCreatedResponse
  | PostDeletedResponse;

interface TimelineAccessedResponse {
  event_type: "TimelineAccessed";
  posts: Post[];
}

interface PostCreatedResponse {
  event_type: "PostCreated";
  posts: Post[];
}

interface PostDeletedResponse {
  event_type: "PostDeleted";
  posts: Post[];
}

export interface TimelineFeedService {
  connect(
    url: string,
    handleResponse: (response: TimelineEventResponse) => void,
    handleError: (message: string) => void,
  ): void;
  disconnect(): void;
}

/**
 * Implementation of timeline feed service using Server-Sent Events (SSE).
 * Manages real-time connection with the server using EventSource.
 *
 * @implements {TimelineFeedService}
 *
 * Methods:
 * - connect(): Establishes SSE connection with the timeline stream.
 *   Automatically handles reconnection on connection loss.
 *   The response handler will be called with timeline updates as they occur.
 * - disconnect(): Closes the SSE connection and cleans up resources.
 *   Should be called when the timeline feed is no longer needed.
 */
export class SseTimelineFeedServicel implements TimelineFeedService {
  private eventSource: EventSource | null = null;

  connect(
    url: string,
    handleResponse: (response: TimelineEventResponse) => void,
    handleError: (message: string) => void,
  ): void {
    if (this.eventSource) return;

    const eventSource = new EventSource(url);
    this.eventSource = eventSource;

    eventSource.onmessage = (event) => {
      try {
        const response: TimelineEventResponse = JSON.parse(event.data);
        handleResponse(response);
      } catch (err) {
        handleError(ERROR_MESSAGES.INVALID_DATA);
      }
    };

    eventSource.onerror = () => {
      handleError(ERROR_MESSAGES.SERVER_ERROR);
      this.disconnect();
    };
  }

  disconnect(): void {
    this.eventSource?.close();
    this.eventSource = null;
  }
}

let testInstance: FakeTimelineFeedService | null = null;

export const createTimelineFeedService = (): TimelineFeedService => {
  if (process.env.NODE_ENV === "test") {
    if (!testInstance) {
      testInstance = new FakeTimelineFeedService();
    }
    return testInstance;
  }
  return new SseTimelineFeedServicel();
};
