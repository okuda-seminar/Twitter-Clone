import { ERROR_MESSAGES } from "@/lib/constants/error-messages";
import type { TimelineItem } from "@/lib/models/post";
import { FakeTimelineFeedService } from "./__fake__/fake-timeline-feed-service";

// ============================================================================
// Initial Fetch Service (REST API - one-time fetch)
// ============================================================================

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
 *   Calls the response handler with timeline items.
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

// ============================================================================
// Polling Service (Continuous updates every 5 seconds)
// ============================================================================

export interface PollingTimelineFeedService {
  startPolling(
    url: string,
    handleNewData: (items: TimelineItem[]) => void,
    handleError: (message: string, isFatal: boolean) => void,
  ): void;
  stopPolling(): void;
}

/**
 * Implementation of timeline feed service using polling.
 * Polls the timeline API every 5 seconds when the page is active.
 *
 * Features:
 * - Polls every 5 seconds
 * - Pauses when page is not visible (Page Visibility API)
 * - Stops after 5 consecutive errors
 * - Cancels ongoing requests on cleanup
 *
 * @implements {PollingTimelineFeedService}
 */
export class RestPollingTimelineFeedService
  implements PollingTimelineFeedService
{
  private intervalId: NodeJS.Timeout | null = null;
  private abortController: AbortController | null = null;
  private consecutiveErrors = 0;
  private readonly MAX_CONSECUTIVE_ERRORS = 5;
  private readonly POLLING_INTERVAL_MS = 5000; // 5 seconds
  private visibilityChangeHandler: (() => void) | null = null;
  private url = "";
  private handleNewData: ((items: TimelineItem[]) => void) | null = null;
  private handleError: ((message: string, isFatal: boolean) => void) | null =
    null;

  startPolling(
    url: string,
    handleNewData: (items: TimelineItem[]) => void,
    handleError: (message: string, isFatal: boolean) => void,
  ): void {
    // Prevent multiple polling instances
    if (this.intervalId) return;

    this.url = url;
    this.handleNewData = handleNewData;
    this.handleError = handleError;
    this.consecutiveErrors = 0;

    // Setup Page Visibility API listener
    this.setupVisibilityListener();

    // Start polling only if page is visible
    if (typeof document !== "undefined" && !document.hidden) {
      this.startInterval();
    }
  }

  stopPolling(): void {
    this.clearInterval();
    this.abortController?.abort();
    this.abortController = null;
    this.removeVisibilityListener();
    this.consecutiveErrors = 0;
  }

  private setupVisibilityListener(): void {
    if (typeof document === "undefined") return;

    this.visibilityChangeHandler = () => {
      if (document.hidden) {
        // Page is hidden, pause polling
        this.clearInterval();
      } else {
        // Page is visible, resume polling
        if (this.consecutiveErrors < this.MAX_CONSECUTIVE_ERRORS) {
          this.startInterval();
        }
      }
    };

    document.addEventListener("visibilitychange", this.visibilityChangeHandler);
  }

  private removeVisibilityListener(): void {
    if (
      typeof document !== "undefined" &&
      this.visibilityChangeHandler !== null
    ) {
      document.removeEventListener(
        "visibilitychange",
        this.visibilityChangeHandler,
      );
      this.visibilityChangeHandler = null;
    }
  }

  private startInterval(): void {
    // Clear any existing interval
    this.clearInterval();

    // TODO: https://github.com/okuda-seminar/Twitter-Clone/issues/861
    // - Migrate from setInterval to useSWR for better data fetching and automatic request deduplication.
    // Start polling
    this.intervalId = setInterval(() => {
      this.poll();
    }, this.POLLING_INTERVAL_MS);
  }

  private clearInterval(): void {
    if (this.intervalId) {
      clearInterval(this.intervalId);
      this.intervalId = null;
    }
  }

  private async poll(): Promise<void> {
    // Cancel any ongoing request
    this.abortController?.abort();
    this.abortController = new AbortController();

    try {
      const response = await fetch(this.url, {
        method: "GET",
        signal: this.abortController.signal,
      });

      if (!response.ok) {
        this.handlePollingError(ERROR_MESSAGES.SERVER_ERROR);
        return;
      }

      const timelineItems: TimelineItem[] = await response.json();

      // Reset error counter on success
      this.consecutiveErrors = 0;

      // Call the handler with new data
      if (this.handleNewData) {
        this.handleNewData(timelineItems);
      }
    } catch (err) {
      // Ignore abort errors (expected when stopping polling)
      if (err instanceof Error && err.name === "AbortError") {
        return;
      }

      this.handlePollingError(ERROR_MESSAGES.INVALID_DATA);
    }
  }

  private handlePollingError(message: string): void {
    this.consecutiveErrors++;

    const isFatal = this.consecutiveErrors >= this.MAX_CONSECUTIVE_ERRORS;

    if (isFatal) {
      // Stop polling after max consecutive errors
      this.stopPolling();
    }

    // Call error handler
    if (this.handleError) {
      this.handleError(message, isFatal);
    }
  }
}

// ============================================================================
// Factory Function
// ============================================================================

let testInstance: FakeTimelineFeedService | null = null;

/**
 * Factory function to create a timeline feed service for initial data fetching.
 *
 * @returns {TimelineFeedService} - A timeline feed service instance
 */
export const createTimelineFeedService = (): TimelineFeedService => {
  if (process.env.NODE_ENV === "test") {
    if (!testInstance) {
      testInstance = new FakeTimelineFeedService();
    }
    return testInstance;
  }
  return new RestTimelineFeedService();
};
