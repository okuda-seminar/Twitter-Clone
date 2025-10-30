import type { TimelineItem } from "@/lib/models/post";
import type {
  PollingTimelineFeedService,
  TimelineFeedService,
} from "../timeline-feed-service";

export class FakeTimelineFeedService implements TimelineFeedService {
  private handleResponse: ((items: TimelineItem[]) => void) | null = null;
  private handleError: ((message: string) => void) | null = null;

  connect(
    url: string,
    handleResponse: (items: TimelineItem[]) => void,
    handleError: (message: string) => void,
  ): void {
    this.handleResponse = handleResponse;
    this.handleError = handleError;
  }

  disconnect(): void {
    this.handleResponse = null;
    this.handleError = null;
  }

  simulateMessage(items: TimelineItem[]): void {
    if (!this.handleResponse) {
      throw new Error("Not connected");
    }
    this.handleResponse(items);
  }

  simulateError(message: string): void {
    if (!this.handleError) {
      throw new Error("Not connected");
    }
    this.handleError(message);
  }
}

export class FakePollingTimelineFeedService
  implements PollingTimelineFeedService
{
  private handleNewData: ((items: TimelineItem[]) => void) | null = null;
  private handleError: ((message: string, isFatal: boolean) => void) | null =
    null;
  private isPolling = false;

  startPolling(
    url: string,
    handleNewData: (items: TimelineItem[]) => void,
    handleError: (message: string, isFatal: boolean) => void,
  ): void {
    this.handleNewData = handleNewData;
    this.handleError = handleError;
    this.isPolling = true;
  }

  stopPolling(): void {
    this.handleNewData = null;
    this.handleError = null;
    this.isPolling = false;
  }

  simulatePollingData(items: TimelineItem[]): void {
    if (!this.isPolling || !this.handleNewData) {
      throw new Error("Not polling");
    }
    this.handleNewData(items);
  }

  simulatePollingError(message: string, isFatal: boolean): void {
    if (!this.isPolling || !this.handleError) {
      throw new Error("Not polling");
    }
    this.handleError(message, isFatal);
  }

  getIsPolling(): boolean {
    return this.isPolling;
  }
}
