import type { TimelineItem } from "@/lib/models/post";
import type { TimelineFeedService } from "../timeline-feed-service";

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
