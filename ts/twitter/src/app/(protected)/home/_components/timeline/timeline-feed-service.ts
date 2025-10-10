import { ERROR_MESSAGES } from "@/lib/constants/error-messages";
import type { TimelineItem } from "@/lib/models/post";
import { FakeTimelineFeedService } from "./__fake__/fake-timeline-feed-service";

export interface TimelineFeedService {
  connect(
    url: string,
    handleResponse: (items: TimelineItem[]) => void,
    handleError: (message: string) => void,
  ): void | Promise<void>;
  disconnect(): void;
}

/**
 * Implementation of timeline feed service using REST API.
 * Fetches timeline items once on connection.
 *
 * @implements {TimelineFeedService}
 *
 * Methods:
 * - connect(): Fetches timeline items from REST API.
 *   Calls the response handler with timeline items wrapped in TimelineAccessed event.
 * - disconnect(): Cancels ongoing requests if any.
 */
export class RestTimelineFeedService implements TimelineFeedService {
  private abortController: AbortController | null = null;

  async connect(
    url: string,
    handleResponse: (items: TimelineItem[]) => void,
    handleError: (message: string) => void,
  ): Promise<void> {
    if (this.abortController) return;

    this.abortController = new AbortController();

    try {
      const response = await fetch(url, {
        method: "GET",
        signal: this.abortController.signal,
      });

      if (!response.ok) {
        handleError(ERROR_MESSAGES.SERVER_ERROR);
        return;
      }

      const timelineItems: TimelineItem[] = await response.json();

      handleResponse(timelineItems);
    } catch (err) {
      if (err instanceof Error && err.name === "AbortError") {
        return;
      }
      handleError(ERROR_MESSAGES.INVALID_DATA);
    }
  }

  disconnect(): void {
    this.abortController?.abort();
    this.abortController = null;
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
  return new RestTimelineFeedService();
};
